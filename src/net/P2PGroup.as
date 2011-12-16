package net
{
	import flash.net.NetConnection;
	import flash.net.NetGroup;

	public class P2PGroup extends NetGroup implements INetGroup
	{
		private var _messageSequence:int;

		public function P2PGroup(connection:NetConnection, groupSpecifier:String)
		{
			super(connection, groupSpecifier);
		}
		
		override public function post(message:Object):String
		{
			message.sequence = _messageSequence++;
			return super.post(message);
		}
	}
}