package design.expressions
{
import ferdinand.core.CoreStorage;

public function SetOverFalse(blockId:int, storage:CoreStorage):void
{
	storage._dataComponents[blockId].isOver = false;
}
}
