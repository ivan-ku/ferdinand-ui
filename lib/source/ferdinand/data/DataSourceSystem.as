package ferdinand.data
{
import ferdinand.core.*;
import ferdinand.debug.AssertInt;
import ferdinand.debug.Log;

import flash.utils.Dictionary;

// This system binds data sources to actual Blocks
public class DataSourceSystem implements ICoreSystem
{
	// cache references to all data sources that are in use:
	protected var _dataSources:Dictionary = new Dictionary(true);

	public function DataSourceSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		// this systems is interested in single component: CoreComponents.DATA_SOURCE
		// therefore we can iterate directly over storage._dataSourceComponents
		var dataSourceComponents:Array = storage._dataSourceComponents;
		for (var blockIdStr:String in dataSourceComponents)
		{
			var blockId:int = int(blockIdStr);
			var dataSourceId:String = dataSourceComponents[blockId];

			CONFIG::DEBUG
			{
				AssertInt(storage._blocks[blockId] & CoreComponents.DATA_SOURCE);
				Log("[DataSourceSystem] block with data source: ", blockId, dataSourceId);
			}

			var source:IData = findSourceById(dataSourceId);
			if (source == null)
			{
				source = CreateData(dataSourceId);
				_dataSources[source] = dataSourceId;
			}

			storage.removeDataSourceComponent(blockId);

			storage.addDataComponent(blockId, source);
		}
	}

	protected function findSourceById(dataSourceId:String):IData
	{
		for (var source:Object in _dataSources)
		{
			if (_dataSources[source] == dataSourceId)
			{
				return IData(source);
			}
		}
		return null;
	}
}
}
