package design.expressions
{
import ferdinand.core.CoreStorage;

public function ToggleAlpha(blockId:int, storage:CoreStorage):void
{
	// original expression written by designer in text file:
	// displayComponent.alpha = dataComponent.isClick ? 0.5 : 1
	// resulting AS3 expression:
	storage._displayComponents[blockId].alpha = storage._dataComponents[blockId].isOver ? 1 : 0.7;
}
}
