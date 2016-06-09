package {

import design.Application;

import ferdinand.create.Base;

import flash.display.Sprite;

public class Main extends Sprite {

    private var content:Sprite = new Sprite();
    private var base:Base;

    public function Main() {
        super();
        // TODO: handle resize and scaling
        // this.addEventListener(Event.RESIZE, handleResize);

        // content will display our application
        content = new Sprite();
        this.addChild(content);

        // use single Base
        base = new Base();
        base.addClassic(Application, content);
    }
}
}
