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
	{
		base.addSkin(listItemsContainerId, "flash.display.Sprite");
		base.addLayout(listItemsContainerId, "vertical");

		var categoryButton:int = base.addBlock(listItemsContainerId);
		{
			base.addSkin(categoryButton, "flash.display.Sprite");
			base.makeInteractive(categoryButton);
			base.addBinding(categoryButton, ToggleAlpha);
			//base.addEventHandler(categoryButton, MouseEvent.CLICK, ToggleExpandedTrue);

			var categoryId:int = base.addBlock(categoryButton);
			base.addSkin(categoryId, "ListCategoryBackground");

			categoryId = base.addBlock(categoryButton);
			base.addSkin(categoryId, "ListCategoryBackgroundUnselected");
		}
	}

	// data binding:
	base.addDataFromFile(selfId, "assets/glossary.csv");

	return selfId;
}
}
