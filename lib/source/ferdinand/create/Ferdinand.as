package ferdinand.create {
import flash.display.DisplayObjectContainer;

// Root Ferdinand instance
public class Ferdinand {

    protected var _base:Base;

    public function Ferdinand() {
        super();
        _base = new Base();
    }

    //TODO: implement addStarling
    public function addClassic(container:DisplayObjectContainer):int {
        var blockId:int = _base.getBlock();
        // TODO:
        // _base.addComponent(blockId, Components.DISPLAY_OBJECT)
        return blockId;
    }

    public function addBlock(parentId:int):int {
        // TODO:
        // _base.addComponent(parentId, Components.DISPLAY_CHILDREN)
        return _base.getBlock();
    }
}
}
