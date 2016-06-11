package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.debug.Assert;

public class ResourceLoadingSubsystem
{
	protected var _resourceURLLoaders:Vector.<ResourceURLLoader> = new Vector.<ResourceURLLoader>();

	public function ResourceLoadingSubsystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{
		// Look for completed requests:
		for (var i:int = 0; i < _resourceURLLoaders.length; i++)
		{
			var loader:ResourceURLLoader = _resourceURLLoaders[i];
			if (loader.state == ResourceURLLoader.STATE_COMPLETE)
			{
				var request:ResourceRequest = loader.resourceRequest;
				switch (request.destinationComponent)
				{
					case CoreComponents.DATA:
						// TODO: implement RawDataParsingSystem
						storage._data[request.blockId] = loader.getData();
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

	public function addRequest(request:ResourceRequest):void
	{
		var loader:ResourceURLLoader = getURLLoader();
		loader.load(request);
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
}
}
