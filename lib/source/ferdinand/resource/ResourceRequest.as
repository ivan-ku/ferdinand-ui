package ferdinand.resource
{

public class ResourceRequest
{
	public var blockId:int;
	public var resourceId:String;
	public var urlLoaderDataFormat:String;
	public var destinationComponent:int;
	public var estimatedNecessityCount:int;

	public function ResourceRequest(blockId:int, resourceId:String, destinationComponent:int, urlLoaderDataFormat:String = null, estimatedNecessityCount:int = 1)
	{
		super();
		this.blockId = blockId;
		this.resourceId = resourceId;
		this.destinationComponent = destinationComponent;
		this.urlLoaderDataFormat = urlLoaderDataFormat;
		this.estimatedNecessityCount = estimatedNecessityCount;
	}

	CONFIG::DEBUG public function toString():String
	{
		return "ResourceRequest: {blockId=" + String(blockId) + ",resourceId=" + String(resourceId) + ",urlLoaderDataFormat=" + String(urlLoaderDataFormat) + ",destinationComponent=" + String(destinationComponent) + ",estimatedNecessityCount=" + String(estimatedNecessityCount) + "}";
	}
}
}
