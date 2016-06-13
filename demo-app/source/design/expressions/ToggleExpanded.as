package design.expressions
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

import flash.utils.Dictionary;

public function ToggleExpanded(blockId:int, storage:CoreStorage):void
{
	const expanded:String = "expanded";
	var data:Dictionary = storage._dataComponents[blockId];
	data[expanded] = !data[expanded];
	storage.notifyChange(blockId, CoreComponents.DATA, expanded);
}
}
