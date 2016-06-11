package design
{
import ferdinand.core.CoreFacade;

// Example of reusable control implementation using Ferdinand AS3-mode
public function DesignGlossaryList(base:CoreFacade, parentId:int):int
{
	var selfId:int = base.addBlock(parentId);

	// TODO: setup visual

	var backgroundId:int = base.addBlock(selfId);
	base.addSkin(backgroundId, "ListBackground");

	var listItemsContainerId:int = base.addBlock(selfId);
	base.addSkin(listItemsContainerId, "flash.display.Sprite");
	base.addLayout(listItemsContainerId, "vertical");
	{
		var categoryId:int = base.addBlock(listItemsContainerId);
		base.addSkin(categoryId, "ListCategoryBackground");
		categoryId = base.addBlock(listItemsContainerId);
		base.addSkin(categoryId, "ListCategoryBackgroundUnselected");
	}

	// data binding:
	base.addDataFromFile(selfId, "assets/glossary.csv");

	return selfId;
}
}
