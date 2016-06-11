package ferdinand.data
{
import ferdinand.core.CoreStorage;
import ferdinand.debug.Assert;

internal function CreateData(storage:CoreStorage, blockId:int, resourceId:String):*
{
	const CSV:String = ".csv";
	const XML:String = ".xml";
	const JSON:String = ".json";

	//naive file type parsing:
	var extension:String = resourceId.substr(resourceId.lastIndexOf(".")).toLowerCase();
	switch (extension)
	{
		case CSV:
			return new DataFromCSV(resourceId);
		default:
		CONFIG::DEBUG
		{
			Assert(false, "Data type not supported");
		}
	}
	return null;
}
}
