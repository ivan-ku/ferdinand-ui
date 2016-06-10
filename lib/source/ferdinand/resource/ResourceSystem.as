package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;
import ferdinand.debug.Log;

import flash.utils.Dictionary;

public class ResourceSystem implements ICoreSystem
{
	// cache of all resources in use:
	private static function processResource(resource:ResourceHandle):void
	{
		switch (resource.request.destinationComponent)
		{
			case CoreComponents.DATA:

				break;
			default:
			CONFIG::DEBUG
			{
				Assert(false, "Destination not supported");
			}
		}
	} // could be static in multiple-instance Ferdinand mode?
	protected var _resourceCache:Dictionary = new Dictionary(true);

	public function ResourceSystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		var resourceRequests:Vector.<ResourceRequest> = storage._resourceRequests;
		for (var i:int = 0; i < resourceRequests.length; ++i)
		{
			var request:ResourceRequest = resourceRequests[i];
			CONFIG::DEBUG
			{
				Log("[ResourceSystem] new resource request: ", request);
			}

			var resource:ResourceHandle = findResource(request);
			if (resource == null)
			{
				resource = new ResourceHandle(request, null);
				_resourceCache[resource] = resourceRequests;
			}
			processResource(resource);
		}
		// clear processed requests
		resourceRequests.length = 0;
	}

	private function findResource(request:ResourceRequest):ResourceHandle
	{
		for (var key:Object in _resourceCache)
		{
			var value:ResourceRequest = _resourceCache[key];
			if (value.resourceId == request.resourceId)
			{
				return ResourceHandle(key);
			}
		}
		return null;
	}
}
}
