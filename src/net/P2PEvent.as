package net
{
	import flash.events.Event;
	
	public class P2PEvent extends Event
	{
		public static const NETCONNECTION_CONNECT_SUCCESS:String = "NetConnection.Connect.Success";
		public static const NETCONNECTION_CONNECT_FAILED:String = "NetConnection.Connect.Failed";
		public static const NETGROUP_CONNECT_SUCCESS:String = "NetGroup.Posting.Success";
		public static const NETGROUP_CONNECT_FAILED:String = "NetGroup.Posting.Failed";
		public static const NETGROUP_POSTING_NOTIFY:String = "NetGroup.Posting.Notify";
		public static const NETGROUP_NEIGHBOR_CONNECT:String = "NetGroup.Neighbor.Connect";
		public var code:String;
		public var info:Object;

		public function P2PEvent(type:String, info:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.code = info.code;
			this.info = info;
			super(type, bubbles, cancelable);
		}
	}
}