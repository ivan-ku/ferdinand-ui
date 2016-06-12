package design
{
import ferdinand.core.CoreStorage;

public function ToggleAlpha(blockId:int, storage:CoreStorage):void
{
	// original expression written by designer in text file:
	// display.alpha = dataComponent.isClick ? 0.5 : 1
	// resulting AS3 expression:
	storage.addSetDisplayPropertyRequest(blockId, "alpha",
			storage._dataComponents[blockId].isOver ? 1 : 0.7);
}
}
