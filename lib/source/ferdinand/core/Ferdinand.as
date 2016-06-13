package ferdinand.core
{
import ferdinand.debug.Assert;

import flash.display.Sprite;

/**
 * Root Ferdinand instance. Front-end for users
 */
public class Ferdinand
{
	protected var _initialized:Boolean = false;
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
		CONFIG::DEBUG
		{
			Assert(!_initialized, "Use reset() before repeated init()");
		}
		_initialized = true;

		var blockId:int = _storage.initByRootBlock(content);
		creation(blockId, _storage);
	}


	/**
	 * Stop Ferdinand and clean-up, everything becomes as it was before init()
	 * Repeated call to init() will re-initialize this instance of Ferdinand
	 * To completely destroy Ferdinand call reset() and set all Ferdinand references to null
	 */
	public function reset():void
	{
		_initialized = false;
		_storage.reset();
	}
}
}
