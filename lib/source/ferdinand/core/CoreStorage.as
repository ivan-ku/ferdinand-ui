package ferdinand.core
{
import ferdinand.data.IData;
import ferdinand.debug.Assert;

import flash.display.DisplayObjectContainer;

// Here all Ferdinand data is stored, public access allowed to simplify System's update()s
public class CoreStorage
{
	// TODO: MAX_BLOCKS should be tunable by the user
	public static const MAX_BLOCKS:int = 1 << 16;

	// blocks:
	public var _blocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);
	public var _displayObjectContainerComponents:Array = new Array(MAX_BLOCKS);

	// components: using sparse Array here to keep memory footprint low
	public var _childBlockComponents:Array = new Array(MAX_BLOCKS);
	public var _skinComponents:Array = new Array(MAX_BLOCKS);
	public var _dataSourceComponents:Array = new Array(MAX_BLOCKS);
	public var _data:Array = new Array(MAX_BLOCKS);
	protected var _blocksCount:int = 0;

	public function CoreStorage()
	{
		super();
	}

	public function getBlock():int
	{
		CONFIG::DEBUG
		{
			var newBlockId:int = _blocksCount + 1;
			Assert(newBlockId < MAX_BLOCKS);
			Assert(_blocks[newBlockId] == CoreComponents.NO_COMPONENTS);
		}
		return _blocksCount++;
	}

	public function addDisplayObjectContainerComponent(blockId:int, container:DisplayObjectContainer):void
	{
		CONFIG::DEBUG
		{
			Assert(!(_blocks[blockId] & CoreComponents.DISPLAY_OBJECT));
		}
		_displayObjectContainerComponents[blockId] = container;
		_blocks[blockId] |= CoreComponents.DISPLAY_OBJECT;
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
	}

	public function addSkinComponent(blockId:int, skin:String):void
	{
		_skinComponents[blockId] = skin;
		_blocks[blockId] |= CoreComponents.SKIN;
	}

	public function addDataSourceComponent(blockId:int, dataSource:String):void
	{
		_dataSourceComponents[blockId] = dataSource;
		_blocks[blockId] |= CoreComponents.DATA_SOURCE;
	}

	public function removeDataSourceComponent(blockId:int):void
	{
		_blocks[blockId] &= ~CoreComponents.DATA_SOURCE;
		delete _dataSourceComponents[blockId];
	}

	public function addDataComponent(blockId:int, data:IData):void
	{
		_data[blockId] = data;
		_blocks[blockId] |= CoreComponents.DATA;
	}
}
}