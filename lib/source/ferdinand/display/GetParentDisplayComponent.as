package ferdinand.display
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

import flash.display.DisplayObjectContainer;

public function GetParentDisplayComponent(blockId:int, storage:CoreStorage):DisplayObjectContainer
{
	var blocks:Vector.<int> = storage._blocks;
	var parents:Array = storage._parentBlockComponents;
	while ((blocks[blockId] & CoreComponents.DISPLAY) == CoreComponents.NO_COMPONENTS)
	{
		blockId = parents[blockId];
	}
	return storage._displayComponents[blockId];
}

}
