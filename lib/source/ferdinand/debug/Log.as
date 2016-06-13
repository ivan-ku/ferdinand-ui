package ferdinand.debug
{
CONFIG::RELEASE public var Log:int = 0;

CONFIG::DEBUG public function Log(...rest):void
{
	trace.apply(null, rest);
}

}
