package ferdinand.resource
{

public class ResourceRequest
{
	public var blockId:int;
	public var resourceId:String;
	public var urlLoaderDataFormat:String;
	public var destinationComponent:int;
	public var estimatedNecessityCount:int;
	public var skinClass:Class;
	public var destinationComponentProperty:String;

	public function ResourceRequest(blockId:int, resourceId:String, destinationComponent:int,
	                                estimatedNecessityCount:int = 1,
	                                destinationComponentProperty:String = "loaded_data")
	{
		super();
		this.blockId = blockId;
		this.resourceId = resourceId;
		this.destinationComponent = destinationComponent;
		this.estimatedNecessityCount = estimatedNecessityCount;
		this.destinationComponentProperty = destinationComponentProperty;
	}

	CONFIG::DEBUG public function toString():String
	{
		return "ResourceRequest: {blockId=" + String(blockId) + ",resourceId=" +
				String(resourceId) + ",urlLoaderDataFormat=" + String(urlLoaderDataFormat) +
				",destinationComponent=" + String(destinationComponent) +
				",destinationComponentProperty=" + String(destinationComponentProperty) +
				",estimatedNecessityCount=" + String(estimatedNecessityCount) + "}";
	}
}
}
