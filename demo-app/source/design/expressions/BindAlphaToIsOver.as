package design.expressions
{
import ferdinand.bind.BindingExpression;
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

	const expression:BindingExpression = new BindingExpression(blockId, CoreComponents.DATA, isOver, blockId, CoreComponents.DISPLAY, alpha);
	expression.transformation = getAlphaValueForIsOver;
	storage.addBinding(expression);
}
}
