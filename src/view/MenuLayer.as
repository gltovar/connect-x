package view
{
	import com.bit101.components.Component;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import com.bit101.utils.MinimalConfigurator;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	
	import event.MenuUIEvent;
	import event.ViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
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
				menuUI.addEventListener( ViewEvent.PERFORM_ACTION, eventForward, false, 0, true);
			}
			
			_menuContainer.addChild( _mainMenuUI );
			_menuUIHistory.unshift( _mainMenuUI );
			
			_menuContainer.x = stage.stageWidth/2;
			_menuContainer.y = stage.stageHeight/2
		}
		
		private function eventForward( e:ViewEvent ):void
		{
			dispatchEvent( e.clone() );
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
				case MenuUIEvent.TO_HIDDEN:
					hideMenu();
					break;
				default:
					
					break;
			}
		}
		
		private function hideMenu():void
		{
			disableCurrentMenuUI();
			_menuUIHistory = new Vector.<AbstractMenuUI>;
			
			TweenMax.to( _menuContainer, .5, {rotationY:_menuContainer.rotationY +  90, ease:Quad.easeIn, onComplete: removeMenuContainerChildren } );
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
			removeMenuContainerChildren();
			
			_menuContainer.addChild( p_menuToShow );
			TweenMax.to( _menuContainer, .5, {rotationY: _menuContainer.rotationY + (p_menuRotationDirection * 90), ease: Quad.easeOut, onComplete: enableCurrentMenuUI} );
		}
		
		private function removeMenuContainerChildren():void
		{
			while(_menuContainer.numChildren)
			{
				_menuContainer.removeChildAt(0);
			}
		}
		
		private function enableCurrentMenuUI():void
		{
			_menuUIHistory[0].enabled = true;
		}
		
		private function disableCurrentMenuUI():void
		{
			_menuUIHistory[0].enabled = false;
		}
		
		public function ReflowLayout():void
		{
			var bounds:Rectangle = _menuContainer.getBounds( _menuContainer );
			
			_menuContainer.x = stage.stageWidth/2;
			_menuContainer.y = stage.stageHeight/2
				
			_menuContainer.scaleX = _menuContainer.scaleY = (stage.stageWidth * .9) / (bounds.width) ;
			
			
			if(  (_menuContainer.getBounds( this ).height) / (stage.stageHeight)   > .9  )
			{
				_menuContainer.scaleY = _menuContainer.scaleX =  (stage.stageHeight * .9) / (bounds.height);
			}
			
			// for 3d transforms
			root.transform.perspectiveProjection.projectionCenter = new Point( _menuContainer.x, _menuContainer.y );
		}
	}
}