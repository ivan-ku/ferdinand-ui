package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;
import ferdinand.debug.Log;

public class ResourceSystem implements ICoreSystem
{
	protected var _resourceLoadingSubsystem:ResourceLoadingSubsystem = new ResourceLoadingSubsystem();
	protected var _resourceSkinSubsystem:ResourceSkinSubsystem = new ResourceSkinSubsystem();

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

			requestNewResource(request);

		}
		// clear processed requests
		resourceRequests.length = 0;

		_resourceSkinSubsystem.update(storage);
		_resourceLoadingSubsystem.update(storage);
	}

	protected function requestNewResource(request:ResourceRequest):void
	{
		switch (request.destinationComponent)
		{
			case CoreComponents.DATA:
				_resourceLoadingSubsystem.addRequest(request);
				break;
			case CoreComponents.SKIN:
				//TODO: loading skin from URL?
				_resourceSkinSubsystem.addRequest(request);
				break;
			default:
			CONFIG::DEBUG
			{
				Assert(false, "Destination not supported");
			}
		}
	}
}
}
