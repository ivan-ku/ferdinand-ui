package design
{
import ferdinand.core.CoreFacade;

// Example of reusable control implementation using Ferdinand AS3-mode
public function DesignGlossaryList(base:CoreFacade, parentId:int):int
{
	var blockId:int = base.addBlock(parentId);
	// TODO: setup structure
	return blockId;
}
}
