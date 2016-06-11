package ferdinand.core
{
import ferdinand.data.IData;
import ferdinand.debug.Assert;
import ferdinand.resource.ResourceRequest;

import flash.display.DisplayObjectContainer;

// Here all Ferdinand data is stored, public access allowed to simplify System's update()s
public class CoreStorage
{
	// TODO: MAX_BLOCKS should be tunable by the user
	public static const MAX_BLOCKS:int = 1 << 16;
	public static const PARENT_COMPONENT_OF_ROOT_BLOCK:int = -1;


	// resource requests:
	public var _resourceRequests:Vector.<ResourceRequest> = new Vector.<ResourceRequest>();

	// components: using sparse Array here to keep memory footprint low
	public var _childBlockComponents:Array = new Array(MAX_BLOCKS); // Array of Vector.<int>
	public var _parentBlockComponents:Array = new Array(MAX_BLOCKS); // Array of int
	public var _displayComponents:Array = new Array(MAX_BLOCKS); // Array of DisplayObjectContainer
	public var _skinComponents:Array = new Array(MAX_BLOCKS); // Array of DisplayObjectContainer
	public var _layoutComponents:Array = new Array(MAX_BLOCKS); // Array of String
	public var _dataComponents:Array = new Array(MAX_BLOCKS); // Array of IData TODO
	public var _position:Array = new Array(MAX_BLOCKS); // Array of Rect

	// blocks:
	public var _blocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);
	protected var _blocksCount:int = 0;

	public function CoreStorage()
	{
		super();
	}

	public function getBlock():int
	{
		var newBlockId:int = _blocksCount + 1;
		CONFIG::DEBUG
		{
			Assert(newBlockId < MAX_BLOCKS);
			Assert(_blocks[newBlockId] == CoreComponents.NO_COMPONENTS);
		}
		_parentBlockComponents[newBlockId] = PARENT_COMPONENT_OF_ROOT_BLOCK;
		return _blocksCount++;
	}

	public function addDisplayComponent(blockId:int, container:DisplayObjectContainer):void
	{
		CONFIG::DEBUG
		{
			Assert((_blocks[blockId] & CoreComponents.DISPLAY) == CoreComponents.NO_COMPONENTS);
		}
		_displayComponents[blockId] = container;
		_blocks[blockId] |= CoreComponents.DISPLAY;
	}

	public function addChildBlockComponent(parentId:int, blockId:int):void
	{
		if ((_blocks[parentId] & CoreComponents.CHILDREN_BLOCKS) != 0)
		{
			_childBlockComponents[parentId].push(blockId);
		}
		else
		{
			_childBlockComponents[parentId] = new <int>[blockId];
			_blocks[parentId] |= CoreComponents.CHILDREN_BLOCKS;
		}
		_parentBlockComponents[blockId] = parentId;
	}

	public function addSkinComponent(blockId:int, skin:DisplayObjectContainer):void
	{
		_skinComponents[blockId] = skin;
		_blocks[blockId] |= CoreComponents.SKIN;
	}

	public function addResourceRequest(dataSource:ResourceRequest):void
	{
		_resourceRequests.push(dataSource);
	}

	public function addDataComponent(blockId:int, data:IData):void
	{
		_dataComponents[blockId] = data;
		_blocks[blockId] |= CoreComponents.DATA;
	}

	public function addLayout(blockId:int, layout:String):void
	{
		_layoutComponents[blockId] = layout.toLowerCase();
		_blocks[blockId] |= CoreComponents.LAYOUT;
	}
}
}