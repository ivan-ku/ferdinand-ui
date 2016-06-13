package ferdinand.debug
{
import ferdinand.core.CoreStorage;

import flash.system.System;
import flash.utils.getTimer;

CONFIG::RELEASE public var DebugSystem:int = 0;

CONFIG::DEBUG public class DebugSystem
{
	public static const STATIC_INIT_MEMORY:uint = System.totalMemory;

	protected var _prevMemory:uint = STATIC_INIT_MEMORY;
	protected var _currentFrameUpdatesCount:uint = 0;
	protected var _beginUpdateTime:int;

	public function DebugSystem()
	{
		super();
		Log("[DebugSystem] STATIC_INIT_MEMORY ", STATIC_INIT_MEMORY)
	}

	public function update():void
	{
		++_currentFrameUpdatesCount;
		var currentMemory:uint = System.totalMemory;
		if (currentMemory > _prevMemory)
		{
			Log("[DebugSystem] current memory ", System.totalMemory);
		}
		_prevMemory = currentMemory;
	}

	public function beginUpdate():void
	{
		_currentFrameUpdatesCount = 0;
		_beginUpdateTime = getTimer();
	}

	public function endUpdate():void
	{
		var updateTime:int = getTimer() - _beginUpdateTime;
		if (updateTime > CoreStorage.UPDATE_TIME_BUDGET + 1)
		{
			Log("[DebugSystem] warning: updateTime", updateTime, "updatesCount",
					_currentFrameUpdatesCount);
		}
	}
}

}
