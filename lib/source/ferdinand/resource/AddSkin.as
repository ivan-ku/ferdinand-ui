package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

public function AddSkin(storage:CoreStorage, blockId:int, skin:String, estimatedCount:int):void
{
	var request:ResourceRequest = new ResourceRequest(blockId, skin, CoreComponents.SKIN, estimatedCount);
	storage.addResourceRequest(request);
}
}
