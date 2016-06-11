package ferdinand.display
{
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;

public class DisplaySystem implements ICoreSystem
{

	public function DisplaySystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		// install all new skins:
		var skins:Array = storage._skinComponents;
		for (var key:String in skins)
		{
			AddDisplayComponent(storage, int(key), skins[key]);
			delete skins[key];
		}
	}
}
}
