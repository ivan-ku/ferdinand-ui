package ferdinand.core
{
import flash.display.Sprite;
import flash.events.Event;

/**
 * Root Ferdinand instance. Front-end for users
 */
public class Ferdinand
{
	protected var _updateInitialized:Boolean = false;
	protected var _storage:CoreStorage = new CoreStorage();

	public function Ferdinand()
	{
		super();
	}

	/**
	 * Associate container with new Ferdinand instance
	 * Start Ferdinand's heartbeat (Event.ENTER_FRAME) handler
	 * @param content must be added to Stage already
	 * @param creation description of Ferdinand instance
	 */
	public function init(content:Sprite, creation:Function):void
	{
		var blockId:int = _storage.getRootBlock();
		if (!_updateInitialized)
		{
			_updateInitialized = true;
			content.addEventListener(Event.ENTER_FRAME, _storage.update, false, 0, true);
		}
		_storage.addDisplayComponent(blockId, content);
		creation(blockId, _storage);
	}


	/**
	 * Stop Ferdinand and clean-up, everything becomes as it was before init()
	 * Repeated call to init() will re-initialize this instance of Ferdinand
	 * To completely destroy Ferdinand call reset() and set all Ferdinand references to null
	 */
	public function reset():void
	{
		// TODO: remove event listener for update
		_storage.reset();
	}
}
}
