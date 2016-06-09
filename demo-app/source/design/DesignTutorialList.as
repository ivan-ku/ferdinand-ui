package design
{
import ferdinand.core.CoreFacade;

public function DesignTutorialList(base:CoreFacade, parentId:int):int
{
	var blockId:int = base.addBlock(parentId);
	// TODO: setup structure
	return blockId;
}

}
