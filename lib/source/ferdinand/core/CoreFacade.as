package ferdinand.core
{
import ferdinand.resource.ResourceRequest;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.net.URLLoaderDataFormat;

// Root CoreFacade instance
public class CoreFacade
{
	protected var _updateInitialized:Boolean = false;

	protected var _storage:CoreStorage = new CoreStorage();

	public function CoreFacade()
	{
		super();
	}

	// TODO: implement free()

	public function createRootBlock(container:DisplayObjectContainer):int
	{
		var blockId:int = _storage.getBlock();
		if (!_updateInitialized)
		{
			_updateInitialized = true;
			container.addEventListener(Event.ENTER_FRAME, _storage.update, false, 0, true);
		}
		_storage.addDisplayComponent(blockId, container);
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
		var request:ResourceRequest = new ResourceRequest(blockId, skin, CoreComponents.SKIN, estimatedNecessityCount);
		_storage.addResourceRequest(request);
	}

	public function addDataFromFile(blockId:int, resourceId:String):void
	{
		var request:ResourceRequest = new ResourceRequest(blockId, resourceId, CoreComponents.DATA);
		request.urlLoaderDataFormat = URLLoaderDataFormat.TEXT;
		_storage.addResourceRequest(request);
	}

	public function addLayout(blockId:int, layout:String):void
	{
		_storage.addLayout(blockId, layout);
	}
}
}
