package ferdinand.display
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;

import flash.utils.Dictionary;

public class DisplaySystem implements ICoreSystem
{

	protected var _propertySetRequests:Dictionary = new Dictionary();
	protected var _dirtyBlocks:Dictionary = new Dictionary();

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

		// set properties:
		for (var blockIdStr:String in _dirtyBlocks)
		{
			var blockId:int = int(blockIdStr);
			if ((storage._blocks[blockId] & CoreComponents.DISPLAY) != CoreComponents.NO_COMPONENTS)
			{
				var requests:Dictionary = _propertySetRequests[blockId];
				for (var propertyName:String in requests)
				{
					storage._displayComponents[blockIdStr][propertyName] = requests[propertyName];
					delete requests[propertyName];
				}
				delete _dirtyBlocks[key];
			}
		}
	}

	public function addDisplayPropertySetRequest(blockId:int, property:String, value:*):void
	{
		if (_propertySetRequests[blockId] == undefined)
		{
			_propertySetRequests[blockId] = new Dictionary();
		}
		// override and ignore all previous set attempts for this property:
		_propertySetRequests[blockId][property] = value;
		_dirtyBlocks[blockId] = true;
	}
}
}
