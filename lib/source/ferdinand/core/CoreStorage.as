package ferdinand.core
{

import ferdinand.debug.Assert;

import flash.display.DisplayObjectContainer;

public class CoreStorage
{
	// TODO: MAX_BLOCKS should be tunable by the user
	public static const MAX_BLOCKS:int = 1 << 16;

	// blocks:
	protected var _lastBlock:int = 0;
	internal var _blocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);

	// components: using sparse Array here to keep memory footprint low
	internal var _classicDisplayObjectContainers:Array = new Array(MAX_BLOCKS);
	internal var _childBlocks:Array = new Array(MAX_BLOCKS);
	internal var _skins:Array = new Array(MAX_BLOCKS);
	internal var _dataSources:Array = new Array(MAX_BLOCKS);

	public function CoreStorage()
	{
		super();
	}

	public function getBlock():int
	{
		CONFIG::DEBUG
		{
			var newBlockId:int = _lastBlock + 1;
			Assert(newBlockId < MAX_BLOCKS);
			Assert(_blocks[newBlockId] == 0);
		}
		return _lastBlock++;
	}

	public function addClassicDisplayObjectContainer(blockId:int, container:DisplayObjectContainer):void
	{
		CONFIG::DEBUG
		{
			Assert((_blocks[blockId] & CoreComponents.DISPLAY_OBJECT) == 0);
		}
		_classicDisplayObjectContainers[blockId] = container;
		_blocks[blockId] |= CoreComponents.DISPLAY_OBJECT;
	}

	public function addChildBlock(parentId:int, blockId:int):void
	{
		if ((_blocks[parentId] & CoreComponents.CHILDREN_BLOCKS) != 0)
		{
			_childBlocks[parentId].push(blockId);
		}
		else
		{
			_childBlocks[parentId] = new <int>[blockId];
			_blocks[parentId] |= CoreComponents.CHILDREN_BLOCKS;
		}
	}

	public function addSkin(blockId:int, skin:String):void
	{
		_skins[blockId] = skin;
		_blocks[blockId] |= CoreComponents.SKIN;
	}

	public function addDataSource(blockId:int, dataSource:String):void
	{
		_dataSources[blockId] = dataSource;
		_blocks[blockId] |= CoreComponents.DATA_SOURCE;
	}

}
}