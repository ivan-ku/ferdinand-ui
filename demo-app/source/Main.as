package
{

import design.DesignApplication;

import ferdinand.core.Ferdinand;

import flash.display.Sprite;

public class Main extends Sprite
{
	public static const FPS:int = 60;

	private var content:Sprite = new Sprite();
	private var ferdinand:Ferdinand = new Ferdinand();

	public function Main()
	{
		super();

		stage.frameRate = FPS;

		this.addChild(content);

		ferdinand.init(content, DesignApplication);
	}
}
}
