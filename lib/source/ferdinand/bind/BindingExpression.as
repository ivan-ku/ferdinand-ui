package ferdinand.bind
{
public class BindingExpression
{
	public var sourceBlockId:int;
	public var sourceComponent:int;
	public var sourceProperty:String;
	public var targetBlockId:int;
	public var targetComponent:int;
	public var targetProperty:String;

	public function BindingExpression(sourceBlockId:int, sourceComponent:int, sourceProperty:String,
	                                  targetBlockId:int, targetComponent:int, targetProperty:String)
	{
		super();
		this.sourceBlockId = sourceBlockId;
		this.sourceComponent = sourceComponent;
		this.sourceProperty = sourceProperty;
		this.targetBlockId = targetBlockId;
		this.targetComponent = targetComponent;
		this.targetProperty = targetProperty;
	}

	public function toString():String
	{
		return "BindingExpression{sourceBlockId=" + String(sourceBlockId) + ",sourceComponent=" +
				String(sourceComponent) + ",sourceProperty=" + String(sourceProperty) +
				",targetBlockId=" + String(targetBlockId) + ",targetComponent=" +
				String(targetComponent) + ",targetProperty=" + String(targetProperty) + "}";
	}

}
}