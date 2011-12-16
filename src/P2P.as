package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.P2PConnection;
	
	import realtimelib.IRealtimeGame;
	import realtimelib.Logger;
	import realtimelib.RealtimeChannelManager;
	import realtimelib.events.PeerStatusEvent;
	import realtimelib.session.P2PSession;
	
	public class P2P extends Sprite
	{
		public var realtimeChannelManager:RealtimeChannelManager;
		public var running:Boolean = false;
		private var session:P2PSession;
		private var serverAddr:String;
		private var groupName:String;
		
		public function get userList():Object{
			return session.mainChat.userList;
		}
		
		public function get myUser():Object{
			return session.myUser;
		}
		
		public function get userListArray():Array{
			var arr:Array = new Array();
			for(var user:Object in userList){
				arr.push(userList[user].userName);
			}
			return arr;
		}
		
		public function get userListMap():Object{
			var obj:Object = new Object();
			for(var id:String in userList){
				obj[id] = userList[id].userName;
			}
			return obj;
		}
		
		public function P2P()
		{
			this.serverAddr = serverAddr;
			this.groupName = groupName;
		}
		
		/**
		 * creates new session and connects to the group with username and details
		 */
		public function connect(userName:String,userDetails:Object=null):void{
			session = new P2PSession(serverAddr,groupName);			
			session.addEventListener(Event.CONNECT, onConnect);
			session.connect(userName,userDetails);
			trace("CONNECT: "+userName);
		}
		
		/**
		 * closes session
		 */
		public function close():void{
			session.close();
		}
		
		/*
		* DEFAULT EVENTS
		*/
		protected function onConnect(event:Event):void{
			Logger.log("onConnect");
			session.addEventListener(Event.CHANGE, onUserListChange);
			session.addEventListener(PeerStatusEvent.USER_ADDED, onUserAdded);
			session.addEventListener(PeerStatusEvent.USER_REMOVED, onUserRemoved);
			
			realtimeChannelManager = new RealtimeChannelManager(session);
			
			dispatchEvent(new Event(Event.CONNECT));
		}
		
		protected function onUserListChange(event:Event):void{
			Logger.log("onUserListChange");
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onUserAdded(event:PeerStatusEvent):void{
			if(event.info.id!=session.myUser.id){
				realtimeChannelManager.addRealtimeChannel(event.info.id, this);
				dispatchEvent(event);
			}
		}
		
		protected function onUserRemoved(event:PeerStatusEvent):void{
			if(event.info.id!=session.myUser.id){
				realtimeChannelManager.removeRealtimeChannel(event.info.id);
				dispatchEvent(event);
			}
		}
	}
}