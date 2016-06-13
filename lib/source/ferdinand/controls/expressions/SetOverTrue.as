package ferdinand.controls.expressions
{
import ferdinand.core.CoreStorage;

public function SetOverTrue(blockId:int, storage:CoreStorage):void
{
	storage._dataComponents[blockId].isOver = true;
}
}
