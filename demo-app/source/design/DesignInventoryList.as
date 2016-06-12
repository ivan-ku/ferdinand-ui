package design
{
import ferdinand.core.Ferdinand;

public function DesignInventoryList(base:Ferdinand, parentId:int):int
{
	var blockId:int = base.addChildBlock(parentId);
	// TODO: setup structure
	return blockId;
}
}
