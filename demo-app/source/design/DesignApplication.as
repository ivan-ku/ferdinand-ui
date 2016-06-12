package design
{
import ferdinand.core.Ferdinand;

import flash.display.Sprite;

// Example of simple application implementation using Ferdinand AS3 mode
public function DesignApplication(base:Ferdinand, container:Sprite):int
{
	// TODO: handle resize and scaling
	// addEventListener(Event.RESIZE, handleResize);

	var myId:int = base.createRootBlock(container);
	// TODO: create buttons to switch controls
	// TODO: create field for search input
	// TODO: create textarea output for DesignTutorialList
	// TODO: create image output for DesignInventoryList
	DesignGlossaryList(base, myId);
	DesignInventoryList(base, myId);
	DesignTutorialList(base, myId);
	return myId;
}
}
