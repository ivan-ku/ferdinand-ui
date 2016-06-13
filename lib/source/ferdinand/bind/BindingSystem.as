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
			var blockId:int = int(key);
			CONFIG::DEBUG
			{
				AssertInt(storage._blocks[key] & CoreComponents.BINDING);
			}
			var blocksBindings:Vector.<Function> = bindingComponents[key];
			for (var i:int = 0; i < blocksBindings.length; i++)
			{
				var bindingExpression:Function = blocksBindings[i];
				bindingExpression.call(null, blockId, storage);
			}
			// TODO: subscription for perpetual bindings must be done here
			delete bindingComponents[key];
		}
	}
}
}
