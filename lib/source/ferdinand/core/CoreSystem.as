package ferdinand.core
{

import ferdinand.debug.Assert;

import flash.display.DisplayObjectContainer;

public class CoreSystem
{

	public static const MAX_BLOCKS:int = 2048;

	// blocks:
	protected var _blocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);
	protected var _lastBlock:int = 0;

	// components:
	protected var _classicDisplayObjectContainers:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>(MAX_BLOCKS, true);
	protected var _childBlocks:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(MAX_BLOCKS, true);


	public function CoreSystem()
	{
		super();
	}

	public function getBlock():int
	{
		CONFIG::DEBUG
		{
			Assert(_lastBlock + 1 < MAX_BLOCKS);
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
}
}
