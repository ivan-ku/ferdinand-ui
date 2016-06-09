package ferdinand.create {
import flash.display.DisplayObjectContainer;

// Root Ferdinand instance
public class Base {
    public function Base() {
        super();
    }

    //TODO: implement addStarling
    public function addClassic(BlockClass:Class, container:DisplayObjectContainer):void {
        var block:Block = new BlockClass(this);
    }
}
}
