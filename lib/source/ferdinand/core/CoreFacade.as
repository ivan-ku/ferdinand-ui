package ferdinand.core
{
import ferdinand.data.DataSourceSystem;
import ferdinand.debug.Assert;
import ferdinand.debug.MemoryMonitoringSystem;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

// Root CoreFacade instance
public class CoreFacade
{
	protected var _updateInitialized:Boolean = false;
	protected var _fps:int;

	protected var _storage:CoreStorage = new CoreStorage();

	//systems:
	protected var _dataSourceSystem:DataSourceSystem = new DataSourceSystem();
	CONFIG::DEBUG protected var _memory:MemoryMonitoringSystem = new MemoryMonitoringSystem();

	public function CoreFacade(fps:int = 60)
	{
		super();
		_fps = fps;
	}

	public function addClassic(container:DisplayObjectContainer):int
	{
		var blockId:int = _storage.getBlock();
		if (!_updateInitialized)
		{
			container.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		_storage.addDisplayObjectContainerComponent(blockId, container);
		return blockId;
	}

	public function addBlock(parentId:int):int
	{
		var blockId:int = _storage.getBlock();
		_storage.addChildBlockComponent(parentId, blockId);
		return blockId;
	}

	public function addSkin(blockId:int, skin:String):void
	{
		// TODO: here we want to convert skin from String to actual Resource
		_storage.addSkinComponent(blockId, skin);
	}

	public function addDataSource(blockId:int, dataSource:String):void
	{
		_storage.addDataSourceComponent(blockId, dataSource);
	}

	protected function update(event:Event):void
	{
		_dataSourceSystem.update(_storage);
		CONFIG::DEBUG
		{
			Assert(event.target.stage.frameRate == _fps);
			_memory.update();
		}
	}
}
}
