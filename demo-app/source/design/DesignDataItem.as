package design
{
import design.expressions.BindAlphaToIsOver;
import design.expressions.BindVisibleToExpanded;
import design.expressions.BindVisibleToNotExpanded;
import design.expressions.ToggleExpanded;

import ferdinand.controls.MakeInteractive;
import ferdinand.core.CoreStorage;
import ferdinand.resource.AddSkin;

import flash.events.MouseEvent;

public function DesignDataItem(blockId:int, storage:CoreStorage):void
{
	var categoryButton:int = storage.getChildBlock(blockId);
	{
		AddSkin(storage, categoryButton, "flash.display.Sprite");
		MakeInteractive(storage, categoryButton);
		storage.addBinding(categoryButton, BindAlphaToIsOver);
		storage.addEventHandler(categoryButton, MouseEvent.CLICK, ToggleExpanded);

		var categoryId:int = storage.getChildBlock(categoryButton);
		AddSkin(storage, categoryId, "ListCategoryBackground");
		storage.addBinding(categoryId, BindVisibleToExpanded);

		categoryId = storage.getChildBlock(categoryButton);
		AddSkin(storage, categoryId, "ListCategoryBackgroundUnselected");
		storage.addBinding(categoryId, BindVisibleToNotExpanded);
	}
}
}
