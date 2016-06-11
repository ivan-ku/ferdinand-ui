package ferdinand.resource
{
import ferdinand.core.CoreStorage;

import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

public class ResourceSkinSubsystem
{
	public static const SKIN_INSTANCE_STATUS_FREE:int = 0;
	public static const SKIN_INSTANCE_STATUS_USED:int = 1;

	// map SkinClass to Vector.<SkinClass>
	protected var _skinInstances:Dictionary = new Dictionary();
	// map SkinClass to Vector.<int>
	protected var _skinInstancesStatus:Dictionary = new Dictionary();

	protected var _instantiateQueue:Vector.<Class> = new Vector.<Class>();

	protected var _pendingRequests:Vector.<ResourceRequest> = new Vector.<ResourceRequest>();

	public function ResourceSkinSubsystem()
	{
		super();
	}

	public function update(storage:CoreStorage):void
	{

	}

	public function addRequest(request:ResourceRequest):void
	{
		var skinClass:Class = getDefinitionByName(request.resourceId) as Class;

		_instantiateQueue.push(skinClass);

		_pendingRequests.push(request)
	}
}
}
