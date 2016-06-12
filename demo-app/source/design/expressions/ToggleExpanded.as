package design.expressions
{
import ferdinand.core.CoreStorage;

import flash.utils.Dictionary;

public function ToggleExpanded(blockId:int, storage:CoreStorage):void
{
	var data:Dictionary = storage._dataComponents[blockId];
	data["expanded"] = !data["expanded"];
}
}
