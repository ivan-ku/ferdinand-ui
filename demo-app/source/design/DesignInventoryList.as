package design {
import ferdinand.create.Ferdinand;

public function DesignInventoryList(base:Ferdinand, parentId:int):int {
    var blockId:int = base.addBlock(parentId);
    // TODO: setup structure
    return blockId;
}
}
