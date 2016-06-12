package ferdinand.data
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

import flash.utils.Dictionary;

public function GetParentDataComponent(storage:CoreStorage, blockId:int):Dictionary
{
	var blocks:Vector.<int> = storage._blocks;
	var parents:Array = storage._parentBlockComponents;
	while ((blocks[blockId] & CoreComponents.DATA) == CoreComponents.NO_COMPONENTS)
	{
		blockId = parents[blockId];
	}
	return storage._dataComponents[blockId];
}

}
