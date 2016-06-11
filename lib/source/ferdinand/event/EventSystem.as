package ferdinand.event
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

public class EventSystem implements ICoreSystem
{
	protected var _eventBus:Vector.<Event> = new Vector.<Event>();

	protected var _registrationQueue:Vector.<EventRegistrationRequest> = new Vector.<EventRegistrationRequest>();

	public function EventSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		for (var i:int = 0; i < _registrationQueue.length; i++)
		{
			var request:EventRegistrationRequest = _registrationQueue[i];
			var display:DisplayObjectContainer = storage._displayComponents[request.blockId];
			if ((storage._blocks[request.blockId] & CoreComponents.DISPLAY) !=
					CoreComponents.NO_COMPONENTS)
			{
				CONFIG::DEBUG
				{
					Assert(!display.hasEventListener(request.eventType),
							"Only one event handler supported!");
				}
				// TODO: unsubscribe when display object changed/removed
				display.addEventListener(request.eventType, allEventsReceiver, false, 0, true);
				// TODO: use another data structure?
				_registrationQueue.splice(i, 1);
			}
		}

		for (i = 0; i < _eventBus.length; i++)
		{
			var event:Event = _eventBus[i];
		}
		// clear processed events
		_eventBus.length = 0;
	}

	public function registerNewHandler(blockId:int, eventType:String, handlerFunction:Function):void
	{
		var request:EventRegistrationRequest = new EventRegistrationRequest(blockId, eventType, handlerFunction);
		_registrationQueue.push(request);
	}

	protected function allEventsReceiver(event:Event):void
	{
		_eventBus.push(event);
	}
}
}
