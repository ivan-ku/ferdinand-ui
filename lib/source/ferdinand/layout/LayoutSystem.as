package ferdinand.layout
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;

public class LayoutSystem implements ICoreSystem
{
	public static const LAYOUT_FUNCTIONS:Object = {
		"vertical": LayoutVertical
	};

	public function LayoutSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		var layouts:Array = storage._layoutComponents;
		for (var key:String in layouts)
		{
			var blockId:int = int(key);
			CONFIG::DEBUG
			{
				Assert((storage._blocks[blockId] & CoreComponents.CHILDREN_BLOCKS) != CoreComponents.NO_COMPONENTS, "");
			}
			LAYOUT_FUNCTIONS[layouts[blockId]](storage, blockId);
		}
	}
}
}
