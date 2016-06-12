package ferdinand.data
{
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.resource.ResourceRequest;

import flash.net.URLLoaderDataFormat;

public function AddDataFromFile(storage:CoreStorage, blockId:int, resourceId:String,
                                destinationComponentProperty:String = "loaded_data"):void
{
	var request:ResourceRequest = new ResourceRequest(blockId, resourceId, CoreComponents.DATA, 1, destinationComponentProperty);
	request.urlLoaderDataFormat = URLLoaderDataFormat.TEXT;
	storage.ensureDataComponentExist(blockId);
	storage.addResourceRequest(request);
}
}
