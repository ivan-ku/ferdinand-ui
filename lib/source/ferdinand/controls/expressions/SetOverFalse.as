package ferdinand.controls.expressions
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function SetOverFalse(blockId:int, storage:CoreStorage):void
{
	const isOver:String = "isOver";
	storage._dataComponents[blockId][isOver] = false;
	storage.notifyChange(blockId, CoreComponents.DATA, isOver);
}
}
