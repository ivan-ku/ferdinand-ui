package ferdinand.data
{

internal class DataFromCSV implements IData
{
	protected var _sourceId:String;

	public function DataFromCSV(sourceId:String)
	{
		super();
		_sourceId = sourceId;
	}

	public function getDataView():DataView
	{
		return null;
	}
}
}
