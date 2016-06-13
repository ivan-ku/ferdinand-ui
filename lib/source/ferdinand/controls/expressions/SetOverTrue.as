package ferdinand.controls.expressions
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function SetOverTrue(blockId:int, storage:CoreStorage):void
{
	const isOver:String = "isOver";
	storage._dataComponents[blockId][isOver] = true;
	storage.notifyChange(blockId, CoreComponents.DATA, isOver);
}
}
