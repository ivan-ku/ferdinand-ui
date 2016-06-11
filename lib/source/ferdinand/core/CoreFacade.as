package ferdinand.core
{
import ferdinand.debug.Assert;
import ferdinand.debug.MemoryMonitoringSystem;
import ferdinand.resource.ResourceRequest;
import ferdinand.resource.ResourceSystem;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.net.URLLoaderDataFormat;

// Root CoreFacade instance
public class CoreFacade
{
	protected var _updateInitialized:Boolean = false;
	protected var _fps:int;

	protected var _storage:CoreStorage = new CoreStorage();

	//systems:
	protected var _dataSourceSystem:ResourceSystem = new ResourceSystem();
	CONFIG::DEBUG protected var _memory:MemoryMonitoringSystem = new MemoryMonitoringSystem();

	public function CoreFacade(fps:int = 60)
	{
		super();
		_fps = fps;
	}

	// TODO: implement free()

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

	public function addSkin(blockId:int, skin:String, estimatedNecessityCount:int = 1):void
	{
		var request:ResourceRequest = new ResourceRequest(blockId, skin, CoreComponents.SKIN, null, estimatedNecessityCount);
		_storage.addResourceRequest(request);
	}

	public function addDataFromFile(blockId:int, resourceId:String):void
	{
		var request:ResourceRequest = new ResourceRequest(blockId, resourceId, CoreComponents.DATA, URLLoaderDataFormat.TEXT);
		_storage.addResourceRequest(request);
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
