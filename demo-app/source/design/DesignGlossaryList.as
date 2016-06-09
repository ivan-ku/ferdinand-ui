package design {
import ferdinand.create.Ferdinand;

// Example of reusable control implementation using Ferdinand AS3-mode
public function DesignGlossaryList(base:Ferdinand, parentId:int):int {
    var blockId:int = base.addBlock(parentId);
    // TODO: setup structure
    return blockId;
}
}
