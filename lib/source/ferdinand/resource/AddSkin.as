package ferdinand.resource
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;

/**
 * Asynchronously create block's display representation
 * @param storage
 * @param blockId
 * @param skin library linkage id supported
 * @param estimatedCount preallocate more than one instance of a skin
 */
public function AddSkin(storage:CoreStorage, blockId:int, skin:String, estimatedCount:int = 1):void
{
	var request:ResourceRequest = new ResourceRequest(blockId, skin, CoreComponents.SKIN, estimatedCount);
	storage.addResourceRequest(request);
}
}
