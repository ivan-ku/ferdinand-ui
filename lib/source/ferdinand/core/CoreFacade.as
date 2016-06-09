package ferdinand.core
{
import ferdinand.debug.MemoryMonitoringSystem;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

// Root CoreFacade instance
public class CoreFacade
{
	protected var _updateInitialized:Boolean = false;
	protected var _fps:int;
	//systems:
	protected var _base:CoreSystem = new CoreSystem();
	CONFIG::DEBUG protected var _memory:MemoryMonitoringSystem = new MemoryMonitoringSystem();

	public function CoreFacade(fps:int = 60)
	{
		super();
		_fps = fps;
	}

	public function addClassic(container:DisplayObjectContainer):int
	{
		var blockId:int = _base.getBlock();
		if (!_updateInitialized)
		{
			container.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		_base.addClassicDisplayObjectContainer(blockId, container);
		return blockId;
	}

	public function addBlock(parentId:int):int
	{
		var blockId:int = _base.getBlock();
		_base.addChildBlock(parentId, blockId);
		return blockId;
	}

	public function update(event:Event = null):void
	{
		CONFIG::DEBUG
		{
			_memory.update();
		}
	}
}
}
