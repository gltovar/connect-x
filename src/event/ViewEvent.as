package event
{
	import flash.events.Event;
	
	public class ViewEvent extends Event
	{
		public static const NEW_SINGLE_PLAYER_GAME:String = "newSinglePlayerGame";
		public static const NEW_LOCAL_MULTIPLAYER_GAME:String = "newLocalMultiplayerGame";
		public static const NEW_ONLINE_MULTIPLAYER_GAME:String = "newRemoteMultiplayerGame";
		
		public static const LOAD_GAME_FROM_SHARED_OBJECT:String = "loadGameFromSharedObject";
		public static const LOAD_GAME_FROM_EXTERNAL_FILE:String = "loadGameFromExternalFile";
		
		public static const SAVE_GAME_TO_SHARED_OBJECT:String = "saveGameToSharedObject";
		public static const SAVE_GAME_TO_EXTERNAL_FILE:String = "saveGameToExternalFile";

		
		public function ViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
		}
		
		public function get gameState():GameState
		{
			return _gameState;
		}
		
		public override function clone():Event {
			return new ViewEvent( type, bubbles, cancelable );
		}
		
		public override function toString():String{
			return formatToString( "ViewEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}