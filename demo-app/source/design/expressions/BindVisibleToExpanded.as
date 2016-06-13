package design.expressions
{
import ferdinand.bind.Bind;
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function BindVisibleToExpanded(targetBlockId:int):Function
{
	function bindingFunction(blockId:int, storage:CoreStorage):void
	{
		const expanded:String = "expanded";
		const visible:String = "visible";
		Bind(storage, blockId, CoreComponents.DATA, expanded, targetBlockId, CoreComponents.DISPLAY,
				visible);

		// TODO: subscription must be done by BindingSystem!
		// continuous binding must be subscribed to property change:
		storage.subscribeToChange(blockId, CoreComponents.DATA, expanded, bindingFunction);
	}

	return bindingFunction;
}
}
