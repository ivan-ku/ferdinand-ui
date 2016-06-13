package ferdinand.core
{
import ferdinand.animation.AnimationSystem;
import ferdinand.bind.BindingSystem;
import ferdinand.data.GetParentDataComponent;
import ferdinand.debug.Assert;
import ferdinand.debug.MemoryMonitoringSystem;
import ferdinand.display.AddDisplayComponent;
import ferdinand.display.DisplaySystem;
import ferdinand.event.FlashEventSystem;
import ferdinand.layout.LayoutSystem;
import ferdinand.resource.ResourceRequest;
import ferdinand.resource.ResourceSystem;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.utils.Dictionary;

// Here all Ferdinand data is stored, public access allowed to simplify System's update()s
public class CoreStorage
{
	// TODO: MAX_BLOCKS should be tunable by the user
	public static const MAX_BLOCKS:int = 1 << 16;
	public static const PARENT_COMPONENT_OF_ROOT_BLOCK:int = -1;

	// components: using sparse Array here to keep memory footprint low
	public var _childBlockComponents:Array = new Array(MAX_BLOCKS); // Vector.<int>
	public var _parentBlockComponents:Array = new Array(MAX_BLOCKS); // int
	public var _displayComponents:Array = new Array(MAX_BLOCKS); // DisplayObjectContainer
	public var _skinComponents:Array = new Array(MAX_BLOCKS); // DisplayObjectContainer
	public var _layoutComponents:Array = new Array(MAX_BLOCKS); // String
	public var _dataComponents:Array = new Array(MAX_BLOCKS); // Dictionary TODO
	public var _boundsComponents:Array = new Array(MAX_BLOCKS); // Rectangle
	// Dictionary {String to Function}:
	public var _eventHandlerComponents:Array = new Array(MAX_BLOCKS);
	public var _bindingComponents:Array = new Array(MAX_BLOCKS); // Vector.<Function>;

	// blocks:
	public var _blocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);
	protected var _blocksCount:int = 0;

	// systems:
	protected var _resourceSystem:ResourceSystem = new ResourceSystem();
	protected var _displaySystem:DisplaySystem = new DisplaySystem();
	protected var _layoutSystem:LayoutSystem = new LayoutSystem();
	protected var _animationSystem:AnimationSystem = new AnimationSystem();
	protected var _flashEventSystem:FlashEventSystem = new FlashEventSystem();
	protected var _bindingSystem:BindingSystem = new BindingSystem();
	CONFIG::DEBUG protected var _memory:MemoryMonitoringSystem = new MemoryMonitoringSystem();

	// Reactions - internal Ferdinand's events
	private var _reactions:Dictionary = new Dictionary();

	public function CoreStorage()
	{
		super();
	}

	public function getRootBlock():int
	{
		var newBlockId:int = getEmptyBlock();
		_parentBlockComponents[newBlockId] = PARENT_COMPONENT_OF_ROOT_BLOCK;
		ensureDataComponentExist(newBlockId, true); // root always has data
		return newBlockId;
	}

	public function addDisplayComponent(blockId:int, container:DisplayObjectContainer):void
	{
		AddDisplayComponent(this, blockId, container);
	}

	public function addChildBlockComponent(parentId:int, blockId:int):void
	{
		if ((_blocks[parentId] & CoreComponents.CHILDREN_BLOCKS) == CoreComponents.NO_COMPONENTS)
		{
			_childBlockComponents[parentId] = new <int>[blockId];
			_blocks[parentId] |= CoreComponents.CHILDREN_BLOCKS;
		}
		else
		{
			_childBlockComponents[parentId].push(blockId);
		}
		_parentBlockComponents[blockId] = parentId;
	}

	public function addSkinComponent(blockId:int, skin:DisplayObjectContainer):void
	{
		_skinComponents[blockId] = skin;
		_blocks[blockId] |= CoreComponents.SKIN;
	}

	public function addResourceRequest(request:ResourceRequest):void
	{
		_resourceSystem.registerRequest(request);
	}

	public function ensureDataComponentExist(blockId:int, newDataScope:Boolean = false):void
	{
		if (_dataComponents[blockId] == undefined)
		{
			if (newDataScope)
			{
				_dataComponents[blockId] = new Dictionary();
			}
			else
			{
				_dataComponents[blockId] = GetParentDataComponent(this, blockId);
			}
			_blocks[blockId] |= CoreComponents.DATA;
		}
	}

	/**
	 * Layout block's children in predefined order
	 * @param blockId block with at lease one child block with Display component
	 * @param layout Supported values: "vertical"
	 */
	public function addLayout(blockId:int, layout:String):void
	{
		_layoutComponents[blockId] = layout.toLowerCase();
		_blocks[blockId] |= CoreComponents.LAYOUT;
	}

	/**
	 * Add expression that executes every time specific event is invoked
	 * @param blockId must have Display component as it's only source of events for now
	 * @param eventType type of event
	 * @param handler TODO special type: EventHandlerExpression
	 */
	public function addEventHandler(blockId:int, eventType:String, handler:Function):void
	{
		var handlers:Dictionary = _eventHandlerComponents[blockId];
		if (handlers == null)
		{
			handlers = new Dictionary();
			_eventHandlerComponents[blockId] = handlers;
		}
		CONFIG::DEBUG
		{
			Assert(handlers[eventType] == undefined, "Only one handler per event allowed!");
		}
		handlers[eventType] = handler;

		_flashEventSystem.registerNewHandler(blockId, eventType, handler);

		_blocks[blockId] |= CoreComponents.EVENT_HANDLER;
		ensureDataComponentExist(blockId);
	}

	/**
	 * Add expression that "binds" destination to source
	 * TODO Expression evaluates every time source is changed
	 * @param blockId
	 * @param bindingExpression TODO special type: BindingExpression
	 */
	public function addBinding(blockId:int, bindingExpression:Function):void
	{
		var bindings:Vector.<Function> = _bindingComponents[blockId];
		if (bindings == null)
		{
			_bindingComponents[blockId] = new <Function>[bindingExpression];
		}
		else
		{
			bindings.push(bindingExpression);
		}

		_blocks[blockId] |= CoreComponents.BINDING;
		ensureDataComponentExist(blockId);
	}

	public function addSetDisplayPropertyRequest(blockId:int, property:String, value:*):void
	{
		_displaySystem.addDisplayPropertySetRequest(blockId, property, value);
	}

	/**
	 * Create new empty block "inside" other block
	 * @param parentId parent's block id
	 * @return blockId of new block
	 */
	public function getChildBlock(parentId:int):int
	{
		var blockId:int = getEmptyBlock();
		addChildBlockComponent(parentId, blockId);
		return blockId;
	}

	public function notifyChange(blockId:int, component:int, propertyName:String):void
	{
		const key:String = blockId + "_" + component + "_" + propertyName;
		const reactions:Vector.<Function> = _reactions[key];
		if (reactions != null)
		{
			for (var i:int = 0; i < reactions.length; i++)
			{
				reactions[i](blockId, this);
			}
		}
	}

	public function subscribeToChange(blockId:int, component:int, propertyName:String,
	                                  reaction:Function):void
	{
		const key:String = blockId + "_" + component + "_" + propertyName;
		
		_reactions[key] = reaction;
	}

	protected function getEmptyBlock():int
	{
		var newBlockId:int = _blocksCount;
		++_blocksCount;
		CONFIG::DEBUG
		{
			Assert(newBlockId < MAX_BLOCKS);
			Assert(_blocks[newBlockId] == CoreComponents.NO_COMPONENTS);
		}
		return newBlockId;
	}

	internal function reset():void
	{
		// TODO: implement
		_reactions = new Dictionary();
	}

	/**
	 * Heartbeat of Ferdinand happens here
	 * Expected to be call
	 * @param event
	 */
	public function update(event:Event):void
	{
		_resourceSystem.update(this);
		_displaySystem.update(this);
		_layoutSystem.update(this);
		_animationSystem.update(this);
		_flashEventSystem.update(this);
		_bindingSystem.update(this);
		CONFIG::DEBUG
		{
			_memory.update();
		}
	}
}
}