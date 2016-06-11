package
{

import design.DesignApplication;

import ferdinand.core.CoreFacade;

import flash.display.Sprite;

public class Main extends Sprite
{
	public static const FPS:int = 60;

	private var content:Sprite = new Sprite();
	private var ferdinand:CoreFacade = new CoreFacade();

	public function Main()
	{
		super();

		stage.frameRate = FPS;

		this.addChild(content);

		DesignApplication(ferdinand, content);
	}
}
}
