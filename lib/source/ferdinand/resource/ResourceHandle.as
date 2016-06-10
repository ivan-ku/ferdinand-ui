package ferdinand.resource
{
// Universal handle for any resource
public class ResourceHandle
{
	public var request:ResourceRequest;
	public var resource:*;

	public function ResourceHandle(request:ResourceRequest, resource:*)
	{
		super();
		this.request = request;
		this.resource = resource;
	}

	CONFIG::DEBUG public function toString():String
	{
		return "ResourceHandle{request=" + String(request) + ",resource=" + String(resource) + "}";
	}
}
}
