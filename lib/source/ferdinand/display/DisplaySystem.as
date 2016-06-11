package ferdinand.display
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class DisplaySystem implements ICoreSystem
{
	protected static function getContainer(blockId:int, storage:CoreStorage):DisplayObjectContainer
	{
		var blocks:Vector.<int> = storage._blocks;
		var parents:Array = storage._parentBlockComponents;
		while ((blocks[blockId] & CoreComponents.DISPLAY) == CoreComponents.NO_COMPONENTS)
		{
			blockId = parents[blockId];
		}
		return storage._displayComponents[blockId];
	}

	public function DisplaySystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		// install skins that are ready:
		var skins:Array = storage._skinComponents;
		for (var key:String in skins)
		{
			var blockId:int = int(key);
			var parentBlockId:int = storage._parentBlockComponents[blockId];
			CONFIG::DEBUG
			{
				Assert(parentBlockId != CoreStorage.PARENT_COMPONENT_OF_ROOT_BLOCK, "Can't set skin for root block!");
			}
			var container:DisplayObjectContainer = getContainer(parentBlockId, storage);
			var obj:DisplayObject = container.addChild(skins[blockId]);
			storage._position[blockId] = obj.getBounds(container);
			storage.addDisplayComponent(blockId, skins[blockId]);
			delete skins[blockId];
		}
	}
}
}
