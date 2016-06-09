package ferdinand.create {
public class Base {

    public static const MAX_BLOCKS:int = 2048;

    protected var _allblocks:Vector.<int> = new Vector.<int>(MAX_BLOCKS, true);
    protected var _lastBlock:int = 0;

    public function Base() {
        super();
    }

    public function getBlock():int {
        // TODO: Debug.assert
        return _lastBlock++;
    }
}
}
