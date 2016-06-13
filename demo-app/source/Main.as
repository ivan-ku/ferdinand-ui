package
{

import design.DesignApplication;

import ferdinand.core.Ferdinand;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

/**
 * Example of application featuring 3 List controls with sorting and filtering, data loading
 * from external files.
 * Using Ferdinand in AS3 mode
 */
public class Main extends Sprite
{
	public static const FPS:int = 60;

	private var content:Sprite = new Sprite();
	private var ferdinand:Ferdinand = new Ferdinand();

	public function Main()
	{
		super();

		stage.frameRate = FPS;
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		// TODO: Ferdinand should be aware if we operate directly on .stage to control Event.RESIZE
		// and FPS
		this.addChild(content);

		// All layout, interaction and  data-manipulations happen inside Ferdinand.
		// No custom Classes or code in Frames needed.
		// We pass Ferdinand description function DesignApplication() written using simple
		// declarative Ferdinand AS3-mode. WYSIWYG editor for such declarative descriptions
		// should be implemented, so it will be accessible for designers and other non-tech people.
		ferdinand.init(content, DesignApplication);
	}
}
}
