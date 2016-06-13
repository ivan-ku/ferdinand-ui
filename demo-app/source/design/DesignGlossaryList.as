package design
{
import ferdinand.controls.LoopOverList;
import ferdinand.core.CoreStorage;
import ferdinand.data.AddDataFromFile;
import ferdinand.resource.AddSkin;

// Example of reusable control implementation using Ferdinand AS3-mode
public function DesignGlossaryList(blockId:int, storage:CoreStorage):int
{
	var selfId:int = storage.getChildBlock(blockId);

	var backgroundId:int = storage.getChildBlock(selfId);
	AddSkin(storage, backgroundId, "ListBackground");

	var listItemsContainerId:int = storage.getChildBlock(selfId);
	{
		AddSkin(storage, listItemsContainerId, "flash.display.Sprite");
		storage.addLayout(listItemsContainerId, "vertical");
		const dataId:String = "glossary_data";
		AddDataFromFile(storage, selfId, "assets/glossary.csv", dataId);
//		DesignDataItem(listItemsContainerId, storage);
		LoopOverList(storage, selfId, dataId, DesignDataItem);
	}

	return selfId;
}
}
