package ferdinand.bind
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function Bind(storage:CoreStorage, sourceBlockId:int, sourceComponent:int,
                     sourceProperty:String, destinationBlockId:int, destinationComponent:int,
                     destinationProperty:String):void
{
	// TODO: get rid of this if!
	if (destinationComponent == CoreComponents.DISPLAY)
	{
		storage.addSetDisplayPropertyRequest(destinationBlockId, destinationProperty,
				storage._allComponents[sourceComponent][sourceBlockId][sourceProperty]);
	}
	else
	{
		storage._allComponents[destinationComponent][destinationBlockId][destinationProperty] =
				storage._allComponents[sourceComponent][sourceBlockId][sourceProperty];
	}
}
}
