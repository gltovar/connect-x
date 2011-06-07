package view.menuui
{
	import com.bit101.components.Component;
	import com.bit101.components.PushButton;
	import com.bit101.utils.MinimalConfigurator;
	
	import event.MenuUIEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import model.GameVO;
	
	/**
	 * AbstractMenuUI standarized the render even, provides a one stop shop for
	 * render management and navigation event handling
	 * which allows the MenuUI's to hand their specific code
	 *  
	 * @author gltovar85
	 * 
	 */	
	public class AbstractMenuUI extends Sprite
	{
		protected var _gameVO:GameVO;
		protected var _menuUI:Component;
		protected var _config:MinimalConfigurator;
		
		public function AbstractMenuUI(p_gameVO:GameVO)
		{
			_gameVO = p_gameVO;
			initialize();
		}
		
		protected function initialize():void
		{
			throw new Error("Abstract class should not be instanciated");
		}
		
		protected function render(p_xml:XML):void
		{
			_config = new MinimalConfigurator( this );
			_config.parseXML( p_xml );
		}
		
		
		/**
		 * If a UI button is for navigations, send it on over 
		 * @param p_pushButtonId the PushButton's Id
		 * Should throw and error if it is not a PushButton.
		 */
		protected function addNavigationPushButtonEventListenerFromPushButtonId( p_pushButtonId:String ):void
		{
			var btn:PushButton = _config.getCompById( p_pushButtonId ) as PushButton;
			btn.addEventListener( MouseEvent.CLICK, onNavigationPushButtonClick, false, 0, false );
		}
		
		/**
		 * Looks at the button's label and determinds where it is trying to go
		 * @param e
		 * Will through an error if it cant figure out where the button is trying to go, just to guard agains spelling errors.
		 * (since the UI is xml generated it would be a bit of work to static the menu labels)
		 */
		protected function onNavigationPushButtonClick(e:MouseEvent):void
		{
			if( e.currentTarget is PushButton )
			{
				var buttonPushed:PushButton = e.currentTarget as PushButton;
				switch( buttonPushed.label.toLowerCase() )
				{
					case 'back':
						dispatchEvent( new MenuUIEvent(MenuUIEvent.NAVIGATE, MenuUIEvent.TO_PREVIOUS_MENU_UI) );
						break;
					case 'continue':
					case 'load game':
						dispatchEvent( new MenuUIEvent(MenuUIEvent.NAVIGATE, MenuUIEvent.TO_LOAD_GAME_MENU) );
						break;
					case 'main menu':	
						dispatchEvent( new MenuUIEvent(MenuUIEvent.NAVIGATE, MenuUIEvent.TO_MAIN_MENU) );
						break;
					case 'new game':	
						dispatchEvent( new MenuUIEvent(MenuUIEvent.NAVIGATE, MenuUIEvent.TO_NEW_GAME_MENU) );
						break;
					case 'local multiplayer':
						dispatchEvent( new MenuUIEvent(MenuUIEvent.NAVIGATE, MenuUIEvent.TO_NEW_LOCAL_MULTIPLAYER_MENU) );
						break;
					case 'options':
						dispatchEvent( new MenuUIEvent(MenuUIEvent.NAVIGATE, MenuUIEvent.TO_OPTIONS_MENU) );
						break;
					default:
						throw new Error("Do not have a case for " + buttonPushed.label);
						break;
				}
			}
			else
			{
				throw new Error("Current target is not of PushButton type");
			}
		}
	}
}