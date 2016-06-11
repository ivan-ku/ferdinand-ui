package ferdinand.display
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.debug.Assert;

import flash.display.DisplayObjectContainer;

public function AddDisplayComponent(storage:CoreStorage, blockId:int,
                                    obj:DisplayObjectContainer):void
{
	var parentBlockId:int = storage._parentBlockComponents[blockId];
	CONFIG::DEBUG
	{
		Assert((storage._blocks[blockId] & CoreComponents.DISPLAY) == CoreComponents.NO_COMPONENTS);
	}
	if (parentBlockId != CoreStorage.PARENT_COMPONENT_OF_ROOT_BLOCK)
	{
		var container:DisplayObjectContainer = GetParentDisplayComponent(parentBlockId, storage);
		container.addChild(obj);
	}

	storage._boundsComponents[blockId] = obj.getBounds(obj);
	storage._displayComponents[blockId] = obj;
	storage._blocks[blockId] |= CoreComponents.DISPLAY;
}
}
