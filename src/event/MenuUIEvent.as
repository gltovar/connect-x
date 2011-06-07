package event
{
	import flash.events.Event;
	
	public class MenuUIEvent extends Event
	{
		
		public static const NAVIGATE:String = "menuUINavigate";
		
		public static const TO_MAIN_MENU:String = "navigateToMainMenu";
		public static const TO_NEW_GAME_MENU:String = "navigateToNewGameMenu";
		public static const TO_LOAD_GAME_MENU:String = "navigateToLoadGameMenu";
		public static const TO_OPTIONS_MENU:String = "navigateToOptionsMenus";
		public static const TO_NEW_LOCAL_MULTIPLAYER_MENU:String = "navigateToNewLocalMultiplayerMenu";
		public static const TO_PREVIOUS_MENU_UI:String = "navigateToPreviousMenuUI";
		public static const TO_HIDDEN:String = "navigateToHidden";
		
		private var _navigationDestination:String;
		public function get navigationDestination():String { return _navigationDestination; }
		
		public function MenuUIEvent(type:String, p_navigationDestination:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_navigationDestination = p_navigationDestination;	
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
			return new MenuUIEvent( type, navigationDestination, bubbles, cancelable );
		}
		
		public override function toString():String{
			return formatToString( "MenuUIEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}