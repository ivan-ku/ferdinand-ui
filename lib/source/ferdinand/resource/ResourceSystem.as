package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.core.ICoreSystem;
import ferdinand.debug.Assert;

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
		_resourceSkinSubsystem.update(storage);
		_resourceLoadingSubsystem.update(storage);
	}

	public function registerRequest(request:ResourceRequest):void
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
