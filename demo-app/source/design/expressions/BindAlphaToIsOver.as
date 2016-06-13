package design.expressions
{
import ferdinand.bind.BindTransformed;
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function BindAlphaToIsOver(blockId:int, storage:CoreStorage):void
{
	// original expression written by designer in text file:
	// display.alpha = dataComponent.isClick ? 0.5 : 1
	// resulting AS3 expression:
	const isOver:String = "isOver";
	const alpha:String = "alpha";

	function getAlphaValueForIsOver(isOverInner:Boolean):Number
	{
		return isOverInner ? 1.0 : 0.7;
	}

	BindTransformed(storage, blockId, CoreComponents.DATA, isOver, blockId, CoreComponents.DISPLAY,
			alpha, getAlphaValueForIsOver);

	// TODO: subscription must be done by BindingSystem!
	// continuous binding must be subscribed to property change:
	storage.subscribeToChange(blockId, CoreComponents.DATA, isOver, BindAlphaToIsOver);
}
}
