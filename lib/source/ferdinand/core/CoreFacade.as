package ferdinand.core
{
import flash.display.DisplayObjectContainer;

// Root CoreFacade instance
public class CoreFacade
{

	protected var _base:CoreSystem;

	public function CoreFacade()
	{
		super();
		_base = new CoreSystem();
	}

	public function addClassic(container:DisplayObjectContainer):int
	{
		var blockId:int = _base.getBlock();
		_base.addClassicDisplayObjectContainer(blockId, container);
		return blockId;
	}

	public function addBlock(parentId:int):int
	{
		var blockId:int = _base.getBlock();
		_base.addChildBlock(parentId, blockId);
		return blockId;
	}
}
}
