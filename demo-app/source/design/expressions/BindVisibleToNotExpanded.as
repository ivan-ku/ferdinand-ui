package design.expressions
{
import ferdinand.bind.BindTransformed;
import ferdinand.bind.InvertBoolean;
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function BindVisibleToNotExpanded(targetBlockId:int):Function
{
	function bindingFunction(blockId:int, storage:CoreStorage):void
	{
		const expanded:String = "expanded";
		const visible:String = "visible";
		BindTransformed(storage, blockId, CoreComponents.DATA, expanded, targetBlockId,
				CoreComponents.DISPLAY, visible, InvertBoolean);

		// TODO: subscription must be done by BindingSystem!
		// continuous binding must be subscribed to property change:
		storage.subscribeToChange(blockId, CoreComponents.DATA, expanded, bindingFunction);
	}

	return bindingFunction;
}
}
