package ferdinand.bind
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.AssertInt;

public class BindingSystem implements ICoreSystem
{
	public function BindingSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		var bindingComponents:Array = storage._bindingComponents;
		for (var key:String in bindingComponents)
		{
			CONFIG::DEBUG
			{
				AssertInt(storage._blocks[key] & CoreComponents.BINDING);
			}
			var blocksBindings:Vector.<BindingExpression> = bindingComponents[key];
			for (var i:int = 0; i < blocksBindings.length; i++)
			{
				const expression:BindingExpression = blocksBindings[i];
				var value:* = storage._allComponents[expression.sourceComponent][expression.sourceBlockId][expression.sourceProperty];
				if (expression.transformation != null)
				{
					value = expression.transformation(value);
				}
				// TODO: get rid of this if!
				if (expression.targetComponent == CoreComponents.DISPLAY)
				{
					storage.addSetDisplayPropertyRequest(expression.targetBlockId,
							expression.targetProperty, value);
				}
				else
				{
					storage._allComponents[expression.targetComponent][expression.targetBlockId][expression.targetProperty] =
							value;
				}

				storage.subscribeToChange(expression.sourceBlockId, expression.sourceComponent,
						expression.sourceProperty, expression);
			}
			// TODO: subscription for perpetual bindings must be done here
			delete bindingComponents[key];
		}
	}
}
}
