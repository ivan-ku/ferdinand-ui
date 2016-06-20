package ferdinand.core
{
import ferdinand.animation.AnimationSystem;
import ferdinand.bind.BindingExpression;
import ferdinand.bind.BindingSystem;
import ferdinand.debug.Assert;
import ferdinand.debug.DebugSystem;
import ferdinand.display.AddDisplayComponent;
import ferdinand.display.DisplaySystem;
import ferdinand.event.FlashEventSystem;
import ferdinand.layout.LayoutSystem;
import ferdinand.resource.ResourceRequest;
import ferdinand.resource.ResourceSystem;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.Dictionary;
import flash.utils.getTimer;

// Here all Ferdinand data is stored, public access allowed to simplify System's update()s
public class CoreStorage
{
	// TODO: MAX_BLOCKS should be tunable by the user
	public static const MAX_BLOCKS:int = 1 << 16;
	public static const UPDATE_TIME_BUDGET:int = 1; // spend maximum 1ms for single update
	public static const PARENT_COMPONENT_OF_ROOT_BLOCK:int = -1;

	// components: using sparse Array here to keep memory footprint low
	public var _displayComponents:Array = new Array(MAX_BLOCKS); // DisplayObjectContainer
	public var _childBlockComponents:Array = new Array(MAX_BLOCKS); // Vector.<int>
	public var _parentBlockComponents:Array = new Array(MAX_BLOCKS); // int
	public var _skinComponents:Array = new Array(MAX_BLOCKS); // DisplayObjectContainer
	public var _layoutComponents:Array = new Array(MAX_BLOCKS); // String
	public var _dataComponents:Array = new Array(MAX_BLOCKS); // Dictionary TODO
	public var _boundsComponents:Array = new Array(MAX_BLOCKS); // Rectangle
	// Dictionary {String to Function}:
	public var _eventHandlerComponents:Array = new Array(MAX_BLOCKS);
	public var _bindingComponents:Array = new Array(MAX_BLOCKS); // Vector.<BindingExpression>;
	public var _allComponents:Dictionary = new Dictionary();

	// blocks:
	public var _blocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);
	protected var _blocksCount:int = 0;
	protected var rootBlockId:int = -1;

	// systems:
	protected var _resourceSystem:ResourceSystem = new ResourceSystem();
	protected var _displaySystem:DisplaySystem = new DisplaySystem();
	protected var _layoutSystem:LayoutSystem = new LayoutSystem();
	protected var _animationSystem:AnimationSystem = new AnimationSystem();
	protected var _flashEventSystem:FlashEventSystem = new FlashEventSystem();
	protected var _bindingSystem:BindingSystem = new BindingSystem();
	CONFIG::DEBUG protected var _debugSystem:DebugSystem = new DebugSystem();

	// Reactions - internal Ferdinand's events
	private var _reactions:Dictionary = new Dictionary(); // BindingExpression

	public function CoreStorage()
	{
		super();
		_allComponents[CoreComponents.DISPLAY] = _displayComponents;
		_allComponents[CoreComponents.LAYOUT] = _layoutComponents;
		_allComponents[CoreComponents.SKIN] = _skinComponents;
		_allComponents[CoreComponents.CHILDREN_BLOCKS] = _childBlockComponents;
		_allComponents[CoreComponents.DATA] = _dataComponents;
		_allComponents[CoreComponents.EVENT_HANDLER] = _eventHandlerComponents;
		_allComponents[CoreComponents.BINDING] = _bindingComponents;
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
	}

	/**
	 * Add expression that "binds" destination to source
	 * @param expression evaluates every time it's source is changed
	 */
	public function addBinding(expression:BindingExpression):void
	{
		var blockId:int = expression.sourceBlockId;
		var bindings:Vector.<BindingExpression> = _bindingComponents[blockId];
		if (bindings == null)
		{
			_bindingComponents[blockId] = new <BindingExpression>[expression];
		}
		else
		{
			bindings.push(expression);
		}

		_blocks[blockId] |= CoreComponents.BINDING;
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
		const reactions:Dictionary = _reactions[key];
		for (var reaction:Object in reactions)
		{
			addBinding(BindingExpression(reaction));
		}
	}

	public function subscribeToChange(blockId:int, component:int, propertyName:String,
	                                  reaction:BindingExpression):void
	{
		const key:String = blockId + "_" + component + "_" + propertyName;

		var reactions:Dictionary = _reactions[key];
		if (reactions == null)
		{
			reactions = new Dictionary();
			_reactions[key] = reactions;
		}
		reactions[reaction] = true;
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
		_dataComponents[newBlockId] = new Dictionary();
		_blocks[newBlockId] |= CoreComponents.DATA;
		return newBlockId;
	}

	internal function initByRootBlock(content:Sprite):int
	{
		content.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		var newBlockId:int = getEmptyBlock();
		rootBlockId = newBlockId;
		_parentBlockComponents[newBlockId] = PARENT_COMPONENT_OF_ROOT_BLOCK;
		addDisplayComponent(newBlockId, content);
		return newBlockId;
	}

	internal function reset():void
	{
		_displayComponents[rootBlockId].addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		// TODO: implement
		_reactions = new Dictionary();
	}

	/**
	 * Heartbeat of Ferdinand happens here
	 * Expected to be call
	 * @param event
	 */
	protected function update(event:Event):void
	{
		var updateStart:int = getTimer();
		CONFIG::DEBUG
		{
			_debugSystem.beginUpdate();
		}
		while ((getTimer() - updateStart) <= UPDATE_TIME_BUDGET)
		{
			_resourceSystem.update(this);
			_displaySystem.update(this);
			_layoutSystem.update(this);
			_animationSystem.update(this);
			_flashEventSystem.update(this);
			_bindingSystem.update(this);
			CONFIG::DEBUG
			{
				_debugSystem.update();
			}
		}
		CONFIG::DEBUG
		{
			_debugSystem.endUpdate();
		}
	}
}
}