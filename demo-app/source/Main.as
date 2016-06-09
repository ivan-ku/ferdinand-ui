package
{

import design.DesignApplication;

import ferdinand.core.CoreFacade;

import flash.display.Sprite;

public class Main extends Sprite
{
	public static const FPS:int = 60;

	private var content:Sprite = new Sprite();
	private var base:CoreFacade;

	public function Main()
	{
		super();
		// TODO: handle resize and scaling
		// this.addEventListener(Event.RESIZE, handleResize);

		// content will display our application
		this.addChild(content);

		base = new CoreFacade(FPS);
		DesignApplication(base, content);
	}
}
}
