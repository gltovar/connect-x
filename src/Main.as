package
{
	import controller.AbstractController;
	import controller.CreateNewGame;
	import controller.HandleLocalMultiplayerGame;
	
	import event.ControllerEvent;
	
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import interfaces.IController;
	import interfaces.IModel;
	import interfaces.IView;
	
	import model.GameState;
	import model.GameVO;
	
	import view.GameLayer;
	import view.HUDLayer;
	import view.MenuLayer;
	
	/**
	 * Connect 4 code challenge, in progress.
	 * immediate feature goals: 
	 * -- connect [ any reasonable number ]
	 * -- any size playing field
	 * -- any reasonable amount of players
	 * -- physics and tween based graphics (togglable)
	 * 
	 * 
	 * way down the line goals:
	 * -- computer AI (with levels)
	 * -- online multiplayer
	 * -- target platforms iOS, Android, PC, MAC
	 * 
	 * @author gltovar85
	 * 
	 */	
	public class Main extends Sprite
	{
		private var _gameVO:GameVO;
		private var _gameLayer:GameLayer;
		private var _menuLayer:MenuLayer;
		private var _hudLayer:HUDLayer;
		
		private var _gameState:GameState;
		
		private var _gameStateControllerStack:Vector.<AbstractController>;
		private var _startNextGameStateController:Boolean = false;
		
		private var _immediateControllerStack:Vector.<AbstractController>;
		
		
		public function Main()
		{
			init();
			
		}
		
		private function init():void
		{	
			stage.frameRate = 60;
			
			_gameStateControllerStack = new Vector.<AbstractController>;
			
			_gameVO = new GameVO();
			_gameLayer = new GameLayer();
			_menuLayer = new MenuLayer(_gameVO);
			_hudLayer = new HUDLayer();
			
			addChild( _gameLayer );
			_gameLayer.x = 30;
			_gameLayer.y = 30;
			
			addChild( _hudLayer ); 
			addChild( _menuLayer );
			
			_gameState = GameState.INIT;
			
			initGameControllers();
			
			addEventListener(Event.ENTER_FRAME, gameLoop, false, 0, false);
			
		}
		
		private function initGameControllers():void
		{
			queueNewState( GameState.CREATE_NEW_GAME );
		}
		
		private function gameLoop(e:Event):void
		{
			if( _gameStateControllerStack.length > 0 && _gameStateControllerStack[0].gameState != _gameState )
			{
				_gameState = _gameStateControllerStack[0].gameState;
				trace("game state: " + _gameState);
				_gameStateControllerStack[0].startController();
			}
		}
		
		private function onControllerQueueGameStateEvent( e:ControllerEvent ):void
		{
			queueNewState( e.gameState );
		}
		
		private function queueNewState(p_gameState:GameState):void
		{
			if( p_gameState != null )
			{
				var tempController:AbstractController = getAbstractControllerFromState( p_gameState );
				tempController.addEventListener( ControllerEvent.QUEUE_GAME_STATE, onControllerQueueGameStateEvent, false, 0, true );
				//tempController.addEventListener( ControllerEvent.CHANGE_IMMEDIATE_STATE, onChangeImmediateStateControllerEvent, false, 0, true );
				tempController.addEventListener( ControllerEvent.COMPLETE, onGameStateControllerComplete, false, 0, true );
				_gameStateControllerStack.push( tempController );
			}
		}
		
		private function getAbstractControllerFromState(p_gameState:GameState):AbstractController
		{
			var result:AbstractController;
			switch(p_gameState)
			{
				case GameState.CREATE_NEW_GAME:
					result = new CreateNewGame();
					result.initController( _menuLayer, _gameVO );
					break;
				case GameState.RUNNING_LOCAL_MULTIPLAYER_GAME:
					result = new HandleLocalMultiplayerGame();
					result.initController( _gameLayer, _gameVO );
					
					break;
				default:
					
					break;
			}
			
			return result;
		}
		
		private function onGameStateControllerComplete( e:ControllerEvent ):void
		{
				_gameStateControllerStack[0].removeEventListener( ControllerEvent.COMPLETE, onGameStateControllerComplete );
				_gameStateControllerStack[0].removeEventListener( ControllerEvent.QUEUE_GAME_STATE, onControllerQueueGameStateEvent );
				_gameStateControllerStack.shift()
				
				//_startNextGameStateController = true;
		}
		
		
	}
}