package ferdinand.core
{
import ferdinand.debug.Assert;
import ferdinand.debug.MemoryMonitoringSystem;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

// Root CoreFacade instance
public class CoreFacade
{
	protected var _updateInitialized:Boolean = false;
	protected var _fps:int;
	//systems:
	protected var _core:CoreSystem = new CoreSystem();
	CONFIG::DEBUG protected var _memory:MemoryMonitoringSystem = new MemoryMonitoringSystem();

	public function CoreFacade(fps:int = 60)
	{
		super();
		_fps = fps;
	}

	public function addClassic(container:DisplayObjectContainer):int
	{
		var blockId:int = _core.getBlock();
		if (!_updateInitialized)
		{
			container.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		_core.addClassicDisplayObjectContainer(blockId, container);
		return blockId;
	}

	public function addBlock(parentId:int):int
	{
		var blockId:int = _core.getBlock();
		_core.addChildBlock(parentId, blockId);
		return blockId;
	}

	public function addSkin(blockId:int, skin:String):void
	{
		// TODO: here we want to convert skin from String to actual Resource
		_core.addSkin(blockId, skin);
	}

	public function addDataSource(blockId:int, dataSource:String):void
	{
		// TODO: here we want to convert dataSource from String to actual Resource
		_core.addDataSource(blockId, dataSource);
	}

	protected function update(event:Event):void
	{
		CONFIG::DEBUG
		{
			Assert(event.target.stage.frameRate == _fps);
			_memory.update();
		}
	}
}
}
