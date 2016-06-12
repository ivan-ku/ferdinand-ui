package ferdinand.controls
{
import ferdinand.controls.expressions.SetOverFalse;
import ferdinand.controls.expressions.SetOverTrue;
import ferdinand.core.CoreStorage;

import flash.events.MouseEvent;

public function MakeInteractive(storage:CoreStorage, blockId:int):void
{
	storage.addEventHandler(blockId, MouseEvent.ROLL_OVER, SetOverTrue);
	storage.addEventHandler(blockId, MouseEvent.ROLL_OUT, SetOverFalse);
	storage.addSetDisplayPropertyRequest(blockId, "mouseChildren", false);
	// TODO: set isDown
}
}
