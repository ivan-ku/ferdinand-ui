package design.expressions
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function BindAlphaToIsOver(blockId:int, storage:CoreStorage):void
{
	// original expression written by designer in text file:
	// display.alpha = dataComponent.isClick ? 0.5 : 1
	// resulting AS3 expression:
	const isOver:String = "isOver";

	storage.addSetDisplayPropertyRequest(blockId, "alpha",
			storage._dataComponents[blockId][isOver] ? 1 : 0.7);

	// continuous binding must be subscribed to property change:
	storage.subscribeToChange(blockId, CoreComponents.DATA, isOver, BindAlphaToIsOver);
}
}
