package design.expressions
{
import ferdinand.core.CoreStorage;

public function BindVisibleToExpanded(blockId:int, storage:CoreStorage):void
{
	storage.addSetDisplayPropertyRequest(blockId, "visible",
			storage._dataComponents[blockId]["expanded"]);
}
}