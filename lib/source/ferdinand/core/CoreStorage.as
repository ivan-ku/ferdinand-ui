package ferdinand.core
{
import ferdinand.animation.AnimationSystem;
import ferdinand.bind.BindingSystem;
import ferdinand.debug.Assert;
import ferdinand.debug.MemoryMonitoringSystem;
import ferdinand.display.AddDisplayComponent;
import ferdinand.display.DisplaySystem;
import ferdinand.event.EventSystem;
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

	//systems:
	protected var _resourceSystem:ResourceSystem = new ResourceSystem();
	protected var _displaySystem:DisplaySystem = new DisplaySystem();
	protected var _layoutSystem:LayoutSystem = new LayoutSystem();
	protected var _animationSystem:AnimationSystem = new AnimationSystem();
	protected var _eventSystem:EventSystem = new EventSystem();
	protected var _bindingSystem:BindingSystem = new BindingSystem();
	CONFIG::DEBUG protected var _memory:MemoryMonitoringSystem = new MemoryMonitoringSystem();

	public function CoreStorage()
	{
		super();
	}

	public function getBlock():int
	{
		var newBlockId:int = _blocksCount;
		++_blocksCount;
		CONFIG::DEBUG
		{
			Assert(newBlockId < MAX_BLOCKS);
			Assert(_blocks[newBlockId] == CoreComponents.NO_COMPONENTS);
		}
		_parentBlockComponents[newBlockId] = PARENT_COMPONENT_OF_ROOT_BLOCK;
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

	public function ensureDataComponentExist(blockId:int):void
	{
		if (_dataComponents[blockId] == undefined)
		{
			_dataComponents[blockId] = new Dictionary();
			_blocks[blockId] |= CoreComponents.DATA;
		}
	}

	public function addLayout(blockId:int, layout:String):void
	{
		_layoutComponents[blockId] = layout.toLowerCase();
		_blocks[blockId] |= CoreComponents.LAYOUT;
	}

	public function addEventHandler(blockId:int, eventName:String, handlerFunction:Function):void
	{
		var handlers:Dictionary = _eventHandlerComponents[blockId];
		if (handlers == null)
		{
			handlers = new Dictionary();
			_eventHandlerComponents[blockId] = handlers;
		}
		CONFIG::DEBUG
		{
			Assert(handlers[eventName] == undefined, "Only one handler per event allowed!");
		}
		handlers[eventName] = handlerFunction;

		_eventSystem.registerNewHandler(blockId, eventName, handlerFunction);

		_blocks[blockId] |= CoreComponents.EVENT_HANDLER;
		ensureDataComponentExist(blockId);
	}

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

	public function update(event:Event):void
	{
		_resourceSystem.update(this);
		_displaySystem.update(this);
		_layoutSystem.update(this);
		_animationSystem.update(this);
		_eventSystem.update(this);
		_bindingSystem.update(this);
		CONFIG::DEBUG
		{
			_memory.update();
		}
	}
}
}