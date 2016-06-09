package {

import design.DesignApplication;

import ferdinand.create.Ferdinand;

import flash.display.Sprite;

public class Main extends Sprite {

    private var content:Sprite = new Sprite();
    private var base:Ferdinand;

    public function Main() {
        super();
        // TODO: handle resize and scaling
        // this.addEventListener(Event.RESIZE, handleResize);

        // content will display our application
        this.addChild(content);

        base = new Ferdinand();
        DesignApplication(base, content);
    }
}
}
