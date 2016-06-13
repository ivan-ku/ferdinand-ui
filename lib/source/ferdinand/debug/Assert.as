package ferdinand.debug
{
CONFIG::RELEASE public var Assert:int = 0;

CONFIG::DEBUG public function Assert(value:Boolean, message:String = "Assertion failed!"):void
{
	if (!value)
	{
		throw new Error(message);
	}
}

}
