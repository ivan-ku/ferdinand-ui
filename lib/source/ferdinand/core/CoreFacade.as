package ferdinand.core
{
import ferdinand.controls.MakeInteractive;
import ferdinand.resource.AddSkin;
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

	public function addSkin(blockId:int, skin:String, estimatedCount:int = 1):void
	{
		AddSkin(_storage, blockId, skin, estimatedCount);
	}

	public function addDataFromFile(blockId:int, resourceId:String):void
	{
		var request:ResourceRequest = new ResourceRequest(blockId, resourceId, CoreComponents.DATA);
		request.urlLoaderDataFormat = URLLoaderDataFormat.TEXT;
		_storage.ensureDataComponentExist(blockId);
		_storage.addResourceRequest(request);
	}

	public function addLayout(blockId:int, layout:String):void
	{
		_storage.addLayout(blockId, layout);
	}

	public function addEventHandler(blockId:int, eventName:String, handler:Function):void
	{
		_storage.addEventHandler(blockId, eventName, handler);
	}

	public function addBinding(blockId:int, bindingExpression:Function):void
	{
		_storage.addBinding(blockId, bindingExpression);
	}

	// sets isOver and isDown states to block's data component
	public function makeInteractive(blockId:int):void
	{
		MakeInteractive(_storage, blockId);
	}
}
}
