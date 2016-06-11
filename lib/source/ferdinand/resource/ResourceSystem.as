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
	protected var _resourceURLLoaders:Vector.<ResourceURLLoader> = new Vector.<ResourceURLLoader>();

	// map ResourceHandle to resourceId
	protected var _resourcesInUse:Dictionary = new Dictionary(true);

	// could be static in multiple-instance Ferdinand mode?

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

			var handle:ResourceHandle = findResource(request);
			if (handle == null)
			{
				handle = new ResourceHandle(request, null);
				_resourcesInUse[handle] = request.resourceId;
				requestNewResource(handle);
			}
			// TODO: resolve request immediately if we already have Resource
		}
		// clear processed requests
		resourceRequests.length = 0;

		// Look for completed requests:
		for (i = 0; i < _resourceURLLoaders.length; i++)
		{
			var loader:ResourceURLLoader = _resourceURLLoaders[i];
			if (loader.state == ResourceURLLoader.STATE_COMPLETE)
			{
				request = loader.resourceHandle.request;
				switch (request.destinationComponent)
				{
					case CoreComponents.DATA:
						// TODO: implement RawDataParsingSystem
						storage._data[request.blockId] = loader.resourceHandle.resource;
						break;
					default:
					CONFIG::DEBUG
					{
						Assert(false, "Destination not supported");
					}
				}
				loader.clearAndStop();
			}
		}
	}

	protected function requestNewResource(resource:ResourceHandle):void
	{
		var request:ResourceRequest = resource.request;
		switch (request.destinationComponent)
		{
			case CoreComponents.DATA:
			CONFIG::DEBUG
			{
				Assert(request.urlLoaderDataFormat != null, "urlLoaderDataFormat must be set for Data requests");
			}
				var loader:ResourceURLLoader = getURLLoader();
				loader.load(resource);
				break;
			default:
			CONFIG::DEBUG
			{
				Assert(false, "Destination not supported");
			}
		}
	}

	protected function getURLLoader():ResourceURLLoader
	{
		for (var i:int = 0; i < _resourceURLLoaders.length; i++)
		{
			var loader:ResourceURLLoader = _resourceURLLoaders[i];
			if (loader.state == ResourceURLLoader.STATE_READY)
			{
				return loader;
			}
		}
		loader = new ResourceURLLoader();
		_resourceURLLoaders.push(loader);
		return loader;
	}

	private function findResource(request:ResourceRequest):ResourceHandle
	{
		var resourceId:String = request.resourceId;
		for (var key:Object in _resourcesInUse)
		{
			var usedResourceId:String = _resourcesInUse[key];
			if (usedResourceId == resourceId)
			{
				return ResourceHandle(key);
			}
		}
		return null;
	}
}
}
