package ferdinand.core
{
import ferdinand.controls.MakeInteractive;
import ferdinand.resource.AddSkin;
import ferdinand.resource.ResourceRequest;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.net.URLLoaderDataFormat;

/**
 * Root Ferdinand instance. Front-end for users
 */
public class Ferdinand
{
	protected var _updateInitialized:Boolean = false;

	protected var _storage:CoreStorage = new CoreStorage();

	public function Ferdinand()
	{
		super();
	}

	// TODO: implement free()

	/**
	 * Associate container with new block
	 * @param container must be added to Stage already
	 * @return blockId of new block
	 */
	public function createRootBlock(container:DisplayObjectContainer):int
	{
		var blockId:int = _storage.getRootBlock();
		if (!_updateInitialized)
		{
			_updateInitialized = true;
			container.addEventListener(Event.ENTER_FRAME, _storage.update, false, 0, true);
		}
		_storage.addDisplayComponent(blockId, container);
		return blockId;
	}

	/**
	 * Create new empty block "inside" other block
	 * @param parentId parent's block id
	 * @return blockId of new block
	 */
	public function addChildBlock(parentId:int):int
	{
		return _storage.getChildBlock(parentId);
	}

	/**
	 * Asynchronously create block's display representation
	 * @param blockId
	 * @param skin library linkage id supported
	 * @param estimatedCount preallocate more than one instance of a skin
	 */
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

	/**
	 * Layout block's children in predefined order
	 * @param blockId block with at lease one child block with Display component
	 * @param layout Supported values: "vertical"
	 */
	public function addLayout(blockId:int, layout:String):void
	{
		_storage.addLayout(blockId, layout);
	}

	/**
	 * Add expression that executes every time specific event is invoked
	 * @param blockId must have Display component as it's only source of events for now
	 * @param eventType type of event
	 * @param handler TODO special type: EventHandlerExpression
	 */
	public function addEventHandler(blockId:int, eventType:String, handler:Function):void
	{
		_storage.addEventHandler(blockId, eventType, handler);
	}

	/**
	 * Add expression that "binds" destination to source
	 * TODO Expression evaluates every time source is changed
	 * @param blockId
	 * @param bindingExpression TODO special type: BindingExpression
	 */
	public function addBinding(blockId:int, bindingExpression:Function):void
	{
		_storage.addBinding(blockId, bindingExpression);
	}

	/**
	 * Sets isOver and isDown states to block's data component
	 * Requires that block has Display component
	 * @param blockId
	 */
	public function makeInteractive(blockId:int):void
	{
		MakeInteractive(_storage, blockId);
	}
}
}
