package net
{
	import com.pblabs.engine.debug.Logger;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	public class P2PConnection extends EventDispatcher
	{
		private const _DOMAIN:String = "rtmfp://p2p.rtmfp.net/";
		private const _DEVELOPER_KEY:String = "8e155f691e45952de79bca03-9aacb6b4f2b6";
		private var _connection:NetConnection;
		private var _messageSequence:int;
		private var _netGroup:NetGroup;

		public function P2PConnection()
		{
			connect();
		}
		
		public function connect():void
		{
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, connectionStatusEvent);
			_connection.connect(_DOMAIN, _DEVELOPER_KEY);
		}
		
		public function post(message:Object):Boolean
		{
			if (!_netGroup)
				return false;
			message.sequence = _messageSequence++;
			_netGroup.post(message);
			return true;
		}
		
		private function connectionStatusEvent(event:NetStatusEvent):void
		{
			var info:Object = event.info;
			Logger.warn(this, "connectionStatusEvent",  info.code);
			dispatchEvent(new P2PEvent(event.type, info));
			dispatchEvent(new P2PEvent(info.code, info));
			if (info.code == P2PEvent.NETCONNECTION_CONNECT_SUCCESS)
			{
				_connection.addEventListener(NetStatusEvent.NET_STATUS, connectionStatusEvent);
				setupP2PGroup();
			}
		}
		
		private function setupP2PGroup():void
		{
			var groupSpecification:GroupSpecifier = new GroupSpecifier("group1");
			groupSpecification.serverChannelEnabled = true;
			groupSpecification.postingEnabled = true;
			_netGroup = new NetGroup(_connection, groupSpecification.groupspecWithAuthorizations());
			_netGroup.addEventListener(NetStatusEvent.NET_STATUS, connectionStatusEvent);
		}
		
		public function disconnect():void
		{
			if (_connection)
				_connection.removeEventListener(NetStatusEvent.NET_STATUS, connectionStatusEvent);
			if (_netGroup)
				_netGroup.removeEventListener(NetStatusEvent.NET_STATUS, connectionStatusEvent);
		}
	}
}