package design
{
import ferdinand.core.CoreFacade;

public function DesignInventoryList(base:CoreFacade, parentId:int):int
{
	var blockId:int = base.addBlock(parentId);
	// TODO: setup structure
	return blockId;
}
}
