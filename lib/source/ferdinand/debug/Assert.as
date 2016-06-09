package ferdinand.debug
{

CONFIG::DEBUG public function Assert(value:Boolean, message:String = "Assertion failed!"):void
{
	if (!value)
	{
		throw new Error(message);
	}
}
}
