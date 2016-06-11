package ferdinand.animation
{
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;

import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;

public class AnimationSystem implements ICoreSystem
{
	public function AnimationSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		var displayComponents:Array = storage._displayComponents;
		for (var key:String in displayComponents)
		{
			var blockId:int = int(key);
			var display:DisplayObjectContainer = displayComponents[key];

			var targetPosition:Rectangle = storage._boundsComponents[blockId];
			display.x = targetPosition.x;
			display.y = targetPosition.y;

			// TODO: implement animations 
		}
	}
}
}
