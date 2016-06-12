package design
{
import ferdinand.core.CoreStorage;

// Example of simple application implementation using Ferdinand AS3 mode
public function DesignApplication(blockId:int, storage:CoreStorage):void
{
	// TODO: handle resize and scaling
	// addEventListener(Event.RESIZE, handleResize);

	// TODO: create buttons to switch controls
	// TODO: create field for search input
	// TODO: create textarea output for DesignTutorialList
	// TODO: create image output for DesignInventoryList
	DesignGlossaryList(blockId, storage);
	DesignInventoryList(blockId, storage);
	DesignTutorialList(blockId, storage);
}
}
