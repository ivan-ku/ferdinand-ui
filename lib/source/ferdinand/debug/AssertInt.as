package ferdinand.debug
{
CONFIG::DEBUG public function AssertInt(value:int, message:String = "Assertion failed!"):void
{
	Assert(value != 0, message);
}
}
