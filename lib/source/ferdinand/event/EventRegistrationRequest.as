package ferdinand.event
{
public class EventRegistrationRequest
{
	public var blockId:int;
	public var eventType:String;
	public var handler:Function;


	public function EventRegistrationRequest(blockId:int, eventType:String, handler:Function)
	{
		super();
		this.blockId = blockId;
		this.eventType = eventType;
		this.handler = handler;
	}

	CONFIG::DEBUG public function toString():String
	{
		return "EventRegistrationRequest{blockId=" + String(blockId) + ",eventType=" +
				String(eventType) + ",handler=" + String(handler) + "}";
	}
}
}
