package design
{
import design.expressions.BindAlphaToIsOver;
import design.expressions.ToggleExpanded;

import ferdinand.bind.BindingExpression;
import ferdinand.bind.InvertBoolean;
import ferdinand.controls.MakeInteractive;
import ferdinand.core.CoreComponents;
import ferdinand.core.CoreStorage;
import ferdinand.resource.AddSkin;

import flash.events.MouseEvent;

public function DesignDataItem(blockId:int, storage:CoreStorage):void
{
	var categoryButton:int = storage.getChildBlock(blockId);
	{
		AddSkin(storage, categoryButton, "flash.display.Sprite");
		MakeInteractive(storage, categoryButton);
		BindAlphaToIsOver(categoryButton, storage);
		storage.addEventHandler(categoryButton, MouseEvent.CLICK, ToggleExpanded);

		var categoryId:int = storage.getChildBlock(categoryButton);
		AddSkin(storage, categoryId, "ListCategoryBackground");
		const expanded:String = "expanded";
		const visible:String = "visible";
		storage.addBinding(
				new BindingExpression(categoryButton, CoreComponents.DATA, expanded, categoryId, CoreComponents.DISPLAY, visible));

		categoryId = storage.getChildBlock(categoryButton);
		AddSkin(storage, categoryId, "ListCategoryBackgroundUnselected");
		const expression:BindingExpression = new BindingExpression(categoryButton, CoreComponents.DATA, expanded, categoryId, CoreComponents.DISPLAY, visible);
		expression.transformation = InvertBoolean;
		storage.addBinding(expression);
	}
}
}
