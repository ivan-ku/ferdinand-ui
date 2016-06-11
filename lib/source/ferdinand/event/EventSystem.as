package ferdinand.event
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.utils.Dictionary;

public class EventSystem implements ICoreSystem
{
	protected var _eventBus:Vector.<Event> = new Vector.<Event>();
	protected var _handlers:Dictionary = new Dictionary(true);
	protected var _displayObjectToBlockId:Dictionary = new Dictionary(true);

	protected var _registrationQueue:Vector.<EventRegistrationRequest> = new Vector.<EventRegistrationRequest>();

	public function EventSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		processRegistrationQueue(storage);

		for (var i:int = 0; i < _eventBus.length; i++)
		{
			var event:Event = _eventBus[i];
			var eventTarget:Object = event.target;
			CONFIG::DEBUG
			{
				Assert(_handlers[event.target][event.type] != undefined);
				Assert(_displayObjectToBlockId[eventTarget] != undefined);
			}
			_handlers[event.target][event.type](_displayObjectToBlockId[eventTarget], storage);
		}
		// clear processed events
		_eventBus.length = 0;
	}

	public function registerNewHandler(blockId:int, eventType:String, handlerFunction:Function):void
	{
		var request:EventRegistrationRequest = new EventRegistrationRequest(blockId, eventType, handlerFunction);
		_registrationQueue.push(request);
	}

	protected function processRegistrationQueue(storage:CoreStorage):void
	{
		for (var i:int = 0; i < _registrationQueue.length; i++)
		{
			var request:EventRegistrationRequest = _registrationQueue[i];
			if ((storage._blocks[request.blockId] & CoreComponents.DISPLAY) !=
					CoreComponents.NO_COMPONENTS)
			{
				var display:DisplayObjectContainer = storage._displayComponents[request.blockId];
				CONFIG::DEBUG
				{
					Assert(!display.hasEventListener(request.eventType),
							"Only one event handler supported!");
				}
				// TODO: unsubscribe when display object changed/removed
				display.addEventListener(request.eventType, allEventsReceiver, false, 0, true);
				if (_handlers[display] == undefined)
				{
					_handlers[display] = new Dictionary();
				}
				_handlers[display][request.eventType] = request.handler;
				_displayObjectToBlockId[display] = request.blockId;
				// TODO: use another data structure?
				_registrationQueue.splice(i, 1);
			}
		}
	}

	protected function allEventsReceiver(event:Event):void
	{
		_eventBus.push(event);
	}
}
}
