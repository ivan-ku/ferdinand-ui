package ferdinand.resource
{
import ferdinand.debug.Assert;
import ferdinand.debug.Log;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ResourceURLLoader
{
	public static const STATE_READY:int = 0;
	public static const STATE_LOADING:int = 1;
	public static const STATE_COMPLETE:int = 2;
	public static const STATE_ERROR:int = 3;

	protected var _urlLoader:URLLoader = new URLLoader();

	public function ResourceURLLoader()
	{
		super();

		_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecurityError, false, 0, true);
		_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError, false, 0, true);
		_urlLoader.addEventListener(Event.COMPLETE, handleComplete, false, 0, true);
	}

	protected var _resourceHandle:ResourceHandle;

	public function get resourceHandle():ResourceHandle
	{
		return _resourceHandle;
	}

	protected var _state:int = STATE_READY;

	public function get state():int
	{
		return _state;
	}

	public function load(resourceHandle:ResourceHandle):void
	{
		_resourceHandle = resourceHandle;

		CONFIG::DEBUG
		{
			Assert(_resourceHandle.resource == null);
		}
		var resourceRequest:ResourceRequest = _resourceHandle.request;
		_urlLoader.dataFormat = resourceRequest.urlLoaderDataFormat;

		_urlLoader.load(new URLRequest(resourceRequest.resourceId));
		_state = STATE_LOADING;
	}

	public function clearAndStop():void
	{
		_urlLoader.close();
		_resourceHandle = null;
		_state = STATE_READY;
	}

	private function handleSecurityError(event:SecurityErrorEvent):void
	{
		CONFIG::DEBUG
		{
			Log("[ResourceURLLoader] handleSecurityError ", event);
		}
		_state = STATE_ERROR;
	}

	private function handleIOError(event:IOErrorEvent):void
	{
		CONFIG::DEBUG
		{
			Log("[ResourceURLLoader] handleIOError", event);
		}
		_state = STATE_ERROR;
	}

	private function handleComplete(event:Event):void
	{
		_resourceHandle.resource = _urlLoader.data;
		_state = STATE_COMPLETE;
	}
}
}
