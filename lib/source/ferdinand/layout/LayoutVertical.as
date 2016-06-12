package ferdinand.layout
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

import flash.geom.Rectangle;

public function LayoutVertical(storage:CoreStorage, blockId:int):void
{
	var children:Vector.<int> = storage._childBlockComponents[blockId];
	var prevChildPosition:Rectangle = new Rectangle(0, 0, 0, 0);
	// align all children below first
	for (var i:int = 0; i < children.length; i++)
	{
		var childId:int = children[i];
		if ((storage._blocks[childId] & CoreComponents.DISPLAY) != CoreComponents.NO_COMPONENTS)
		{
			var childPosition:Rectangle = storage._boundsComponents[childId];
			childPosition.y = prevChildPosition.y + prevChildPosition.height;
			storage.addSetDisplayPropertyRequest(childId, "y", childPosition.y);
			prevChildPosition = childPosition;
		}
	}
}
}
