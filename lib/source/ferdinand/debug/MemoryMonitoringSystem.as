package ferdinand.debug
{
import flash.system.System;

CONFIG::RELEASE public var MemoryMonitoringSystem:int = 0;

CONFIG::DEBUG public class MemoryMonitoringSystem
{
	public static const STATIC_INIT_MEMORY:uint = System.totalMemory;

	protected var _prevMemory:uint = STATIC_INIT_MEMORY;

	public function MemoryMonitoringSystem()
	{
		super();
		Log("[MemoryMonitoringSystem] STATIC_INIT_MEMORY ", STATIC_INIT_MEMORY)
	}

	public function update():void
	{
		var currentMemory:uint = System.totalMemory;
		if (currentMemory > _prevMemory)
		{
			Log("[MemoryMonitoringSystem] current memory ", System.totalMemory);
		}
		_prevMemory = currentMemory;
	}
}

}
