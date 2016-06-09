package design
{
import ferdinand.core.CoreFacade;

// Example of reusable control implementation using Ferdinand AS3-mode
public function DesignGlossaryList(base:CoreFacade, parentId:int):int
{
	var selfId:int = base.addBlock(parentId);

	// TODO: setup visual
	var backgroundId:int = base.addBlock(selfId);
	base.addSkin(backgroundId, "ListBackgroundSkin");

	// data binding:
	base.addDataSource(selfId, "glossary.csv");

	return selfId;
}
}
