package design
{
import design.expressions.BindAlphaToIsOver;
import design.expressions.BindVisibleToExpanded;
import design.expressions.BindVisibleToNotExpanded;
import design.expressions.ToggleExpanded;

import ferdinand.core.CoreFacade;

import flash.events.MouseEvent;

// Example of reusable control implementation using Ferdinand AS3-mode
public function DesignGlossaryList(base:CoreFacade, parentId:int):int
{
	var selfId:int = base.addChildBlock(parentId);

	// TODO: setup visual

	var backgroundId:int = base.addChildBlock(selfId);
	base.addSkin(backgroundId, "ListBackground");

	var listItemsContainerId:int = base.addChildBlock(selfId);
	{
		base.addSkin(listItemsContainerId, "flash.display.Sprite");
		base.addLayout(listItemsContainerId, "vertical");

		var categoryButton:int = base.addChildBlock(listItemsContainerId);
		{
			base.addSkin(categoryButton, "flash.display.Sprite");
			base.makeInteractive(categoryButton);
			base.addBinding(categoryButton, BindAlphaToIsOver);
			base.addEventHandler(categoryButton, MouseEvent.CLICK, ToggleExpanded);

			var categoryId:int = base.addChildBlock(categoryButton);
			base.addSkin(categoryId, "ListCategoryBackground");
			base.addBinding(categoryId, BindVisibleToExpanded);

			categoryId = base.addChildBlock(categoryButton);
			base.addSkin(categoryId, "ListCategoryBackgroundUnselected");
			base.addBinding(categoryId, BindVisibleToNotExpanded);
		}
	}

	// data binding:
	base.addDataFromFile(selfId, "assets/glossary.csv");

	return selfId;
}
}
