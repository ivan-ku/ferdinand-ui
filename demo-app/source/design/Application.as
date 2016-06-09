package design {
import ferdinand.create.Base;
import ferdinand.create.Block;

// Example of simple application implementation using Ferdinand AS3-mode
public class Application extends Block {

    protected var glossary:GlossaryList;

    public function Application(base:Base) {
        super(base);
        // TODO: create buttons to switch controls
        // TODO: create TutorialList
        // TODO: create InventoryList
        this.add(GlossaryList);
    }
}
}
