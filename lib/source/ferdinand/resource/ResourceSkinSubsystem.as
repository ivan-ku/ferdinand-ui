package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.debug.Assert;

import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

public class ResourceSkinSubsystem
{
	public static const SKIN_INSTANCE_STATUS_FREE:int = 0;
	public static const SKIN_INSTANCE_STATUS_USED:int = 1;

	// map SkinClass to (map int to instance of SkinClass)
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
		for (var i:int = 0; i < _instantiateQueue.length; i++)
		{
			var skinClass:Class = _instantiateQueue[i];
			var statusOfInstances:Vector.<int> = _skinInstancesStatus[skinClass];
			_skinInstances[skinClass][statusOfInstances.length] = new skinClass();
			statusOfInstances.push(SKIN_INSTANCE_STATUS_FREE);
		}
		_instantiateQueue.length = 0;

		for (i = 0; i < _pendingRequests.length; ++i)
		{
			resolveRequest(_pendingRequests[i], storage);
		}
		_pendingRequests.length = 0;
	}

	public function addRequest(request:ResourceRequest):void
	{
		var skinClass:Class = getDefinitionByName(request.resourceId) as Class;
		request.skinClass = skinClass;

		if (_skinInstances[skinClass] == undefined)
		{
			_skinInstances[skinClass] = new Dictionary();
			_skinInstancesStatus[skinClass] = new Vector.<int>();
		}

		_pendingRequests.push(request);

		for (var i:int = 0; i < request.estimatedNecessityCount; ++i)
		{
			_instantiateQueue.push(skinClass);
		}
	}

	protected function resolveRequest(resourceRequest:ResourceRequest, storage:CoreStorage):void
	{
		var skinClass:Class = resourceRequest.skinClass;
		CONFIG::DEBUG
		{
			Assert(skinClass != null);
		}
		var statusOfInstances:Vector.<int> = _skinInstancesStatus[skinClass];
		for (var i:int = 0; i < statusOfInstances.length; ++i)
		{
			if (statusOfInstances[i] == SKIN_INSTANCE_STATUS_FREE)
			{
				statusOfInstances[i] = SKIN_INSTANCE_STATUS_USED;
				switch (resourceRequest.destinationComponent)
				{
					case CoreComponents.SKIN:
						storage.addSkinComponent(resourceRequest.blockId,
								_skinInstances[skinClass][i]);
						break;
					default:
					CONFIG::DEBUG
					{
						Assert(false, "Destination not supported");
					}
				}
				// return on success:
				return;
			}
		}
		CONFIG::DEBUG
		{
			Assert(false, "Can't resolve request! It's a bug.");
		}
	}
}
}
