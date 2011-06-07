package event
{
	import flash.events.Event;
	
	import model.GameState;
	
	public class ControllerEvent extends Event
	{
		static public const COMPLETE:String = "ControllerEventComplete";
		static public const QUEUE_GAME_STATE:String = "QueueGameState";
		static public const CHANGE_IMMEDIATE_STATE:String = "ChangeImmediateState";
		
		private var _gameState:GameState
		
		public function ControllerEvent(type:String, p_gameState:GameState = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_gameState = p_gameState;
			super(type, bubbles, cancelable);
		}
		
		public function get gameState():GameState
		{
			return _gameState;
		}

		public override function clone():Event {
			return new ControllerEvent( type, _gameState, bubbles, cancelable );
		}
		
		public override function toString():String{
			return formatToString( "ControllerEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}