package view
{
	import com.bit101.components.Component;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import com.bit101.utils.MinimalConfigurator;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	
	import event.MenuUIEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	
	import interfaces.IView;
	
	import model.GameVO;
	
	import view.menuui.AbstractMenuUI;
	import view.menuui.LoadMenuUI;
	import view.menuui.MainMenuUI;
	import view.menuui.NewGameMenuUI;
	import view.menuui.NewLocalMultiplayerMenuUI;
	import view.menuui.OptionsMenuUI;
	
	public class MenuLayer extends Sprite implements IView
	{
		private static const MENU_ROTATION_RIGHT:int = 1;
		private static const MENU_ROTATION_LEFT:int = -1;
		
		private var _gameVO:GameVO;
		
		private var _config:MinimalConfigurator;
		private var _menuContainer:Sprite;
		
		private var _menuUIs:Vector.<AbstractMenuUI>;
		private var _menuUIHistory:Vector.<AbstractMenuUI>;
		
		private var _mainMenuUI:AbstractMenuUI;
		private var _newGameMenuUI:AbstractMenuUI;
		private var _loadGameMenuUI:AbstractMenuUI;
		private var _optionsMenuUI:AbstractMenuUI;
		private var _newLocalMultiplayerGameMenuUI:AbstractMenuUI;
		
		public function MenuLayer(p_gameVO:GameVO)
		{
			_gameVO = p_gameVO;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			
			_menuUIHistory = new Vector.<AbstractMenuUI>;
			
			_menuContainer = new Sprite();
			addChild(_menuContainer);
			_menuContainer.x = 200;
			_menuContainer.y = 200;
			
			Component.initStage( stage );
			
			_menuUIs = new Vector.<AbstractMenuUI>;
			_menuUIs.push( _mainMenuUI = new MainMenuUI(_gameVO) );
			_menuUIs.push( _newGameMenuUI = new NewGameMenuUI(_gameVO) );
			_menuUIs.push( _loadGameMenuUI = new LoadMenuUI(_gameVO) );
			_menuUIs.push( _optionsMenuUI = new OptionsMenuUI(_gameVO) );
			_menuUIs.push( _newLocalMultiplayerGameMenuUI = new NewLocalMultiplayerMenuUI(_gameVO) );
			
			var menuUI:AbstractMenuUI;
			for each(menuUI in _menuUIs)
			{
				menuUI.addEventListener( MenuUIEvent.NAVIGATE, onMenuUINavigate, false, 0, true);
			}
			
			_menuContainer.addChild( _mainMenuUI );
			_menuUIHistory.unshift( _mainMenuUI );
			
		}
		
		private function onMenuUINavigate( e:MenuUIEvent ):void
		{
			switch(e.navigationDestination)
			{
				case MenuUIEvent.TO_LOAD_GAME_MENU:
					startMenuTransition( _loadGameMenuUI, MENU_ROTATION_RIGHT );
					break;
				case MenuUIEvent.TO_MAIN_MENU:
					startMenuTransition( _mainMenuUI, MENU_ROTATION_RIGHT );
					break;
				case MenuUIEvent.TO_NEW_GAME_MENU:
					startMenuTransition( _newGameMenuUI, MENU_ROTATION_RIGHT );
					break;
				case MenuUIEvent.TO_NEW_LOCAL_MULTIPLAYER_MENU:
					startMenuTransition( _newLocalMultiplayerGameMenuUI, MENU_ROTATION_RIGHT );
					break;
				case MenuUIEvent.TO_OPTIONS_MENU:
					startMenuTransition( _optionsMenuUI, MENU_ROTATION_RIGHT );
					break;
				case MenuUIEvent.TO_PREVIOUS_MENU_UI:
					_menuUIHistory.shift()
					startMenuTransition(_menuUIHistory[0], MENU_ROTATION_LEFT, false );
					break;
				default:
					
					break;
			}
		}
		
		private function startMenuTransition( p_menuToShow:AbstractMenuUI, p_menuRotationDirection:int, p_addBreadCrumb:Boolean = true ):void
		{
			disableCurrentMenuUI();
			
			if( p_addBreadCrumb )
			{
				_menuUIHistory.unshift( p_menuToShow );
			}
			
			disableCurrentMenuUI();
			
			TweenMax.to( _menuContainer, .5, {rotationY:_menuContainer.rotationY + (p_menuRotationDirection * 90), ease:Quad.easeIn, onComplete: updateCurrentMenuContainer, onCompleteParams:[p_menuToShow, p_menuRotationDirection]} );
		}
		
		private function updateCurrentMenuContainer( p_menuToShow:AbstractMenuUI, p_menuRotationDirection:int ):void
		{
			_menuContainer.rotationY -= p_menuRotationDirection * 180;
			while(_menuContainer.numChildren)
			{
				_menuContainer.removeChildAt(0);
			}
			
			_menuContainer.addChild( p_menuToShow );
			TweenMax.to( _menuContainer, .5, {rotationY: _menuContainer.rotationY + (p_menuRotationDirection * 90), ease: Quad.easeOut, onComplete: enableCurrentMenuUI} );
		}
		
		private function enableCurrentMenuUI():void
		{
			_menuUIHistory[0].mouseEnabled = true;
			_menuUIHistory[0].mouseChildren = true;
		}
		
		private function disableCurrentMenuUI():void
		{
			_menuUIHistory[0].mouseEnabled = false;
			_menuUIHistory[0].mouseChildren = false;
		}
	}
}