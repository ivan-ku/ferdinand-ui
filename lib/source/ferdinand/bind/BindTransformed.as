package ferdinand.bind
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function BindTransformed(storage:CoreStorage, sourceBlockId:int, sourceComponent:int,
                                sourceProperty:String, destinationBlockId:int,
                                destinationComponent:int, destinationProperty:String,
                                transformation:Function):void
{
	const value:* = transformation(
			storage._allComponents[sourceComponent][sourceBlockId][sourceProperty]);
	// TODO: get rid of this if!
	if (destinationComponent == CoreComponents.DISPLAY)
	{
		storage.addSetDisplayPropertyRequest(destinationBlockId, destinationProperty, value);
	}
	else
	{
		storage._allComponents[destinationComponent][destinationBlockId][destinationProperty] =
				value;
	}
}
}
