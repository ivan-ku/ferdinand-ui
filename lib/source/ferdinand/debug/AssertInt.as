package ferdinand.debug
{
CONFIG::RELEASE public var AssertInt:int = 0;

CONFIG::DEBUG public function AssertInt(value:int, message:String = "Assertion failed!"):void
{
	Assert(value != 0, message);
}

}
