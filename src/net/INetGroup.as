package net
{
	import flash.events.IEventDispatcher;

	public interface INetGroup extends IEventDispatcher
	{
		function post(message:Object):String;
	}
}