package ferdinand.debug
{
CONFIG::DEBUG public function Log(...rest):void
{
	trace.apply(null, rest);
}
}
