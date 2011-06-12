package
{
	import controller.AbstractController;
	import controller.CreateNewGame;
	import controller.HandleLocalMultiplayerGame;
	
	import event.ControllerEvent;
	import event.ViewEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import flash.utils.setTimeout;
	
	import interfaces.IController;
	import interfaces.IModel;
	import interfaces.IView;
	
	import model.GameState;
	import model.GameVO;
	import model.PieceVO;
	import model.PlayerVO;
	
	import view.GameLayer;
	import view.HUDLayer;
	import view.MenuLayer;
	import view.ViewContainer;
	
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
	
	[SWF(width="800", height="480", backgroundColor="#ffffff", frameRate="30")]
	public class Main extends Sprite
	{
		private var _gameVO:GameVO;
		private var _gameLayer:GameLayer;
		private var _menuLayer:MenuLayer;
		private var _hudLayer:HUDLayer;
		private var _viewContainer:ViewContainer;
		
		private var _gameState:GameState;
		
		private var _gameStateControllerStack:Vector.<AbstractController>;
		private var _startNextGameStateController:Boolean = false;
		
		private var _immediateControllerStack:Vector.<AbstractController>;
		
		
		public function Main()
		{
			init();
			
		}
		
		private function defaultGameVO():void
		{
			_gameVO = new GameVO();
			_gameVO.rows = 6;
			_gameVO.columns = 7;
			_gameVO.winningConnectionQuantity = 4;
			
			_gameVO.pieces = new Vector.<PieceVO>;
			
			_gameVO.players = new Vector.<PlayerVO>;
			_gameVO.players.push( new PlayerVO() );
			_gameVO.players.push( new PlayerVO() );
			
			_gameVO.players[0].playerId = '0';
			_gameVO.players[0].playerName = 'player1';
			_gameVO.players[0].pieces = new Vector.<String>;
			_gameVO.players[1].playerId = '1';
			_gameVO.players[1].playerName = 'player2';
			_gameVO.players[1].pieces = new Vector.<String>;
		}
		
		private function init():void
		{	
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			
			_gameStateControllerStack = new Vector.<AbstractController>;
			
			defaultGameVO();
			
			_viewContainer = new ViewContainer();
			_viewContainer.addEventListener( ViewEvent.PERFORM_ACTION, onPerformActionRequest, false, 0, true );
			addChild( _viewContainer );
			
			_gameLayer = new GameLayer(_gameVO);
			_menuLayer = new MenuLayer(_gameVO);
			_hudLayer = new HUDLayer();
			
			_viewContainer.addLayer( _gameLayer );
			_viewContainer.addLayer( _menuLayer );
			_viewContainer.addLayer( _hudLayer );
			
			_gameState = GameState.INIT;
			
			initGameControllers();
			
			addEventListener(Event.ENTER_FRAME, gameLoop, false, 0, false);
			
			setTimeout( reflowLayout, 200 );
		}
		
		private function reflowLayout():void
		{
			_viewContainer.reflowLayout();
		}
		
		private function onStageResize(e:Event):void
		{
			/*trace( 'w: ' + stage.stageWidth + ', h: ' + stage.stageHeight );
			_gameLayer.ReflowLayout();
			_menuLayer.ReflowLayout();*/
		}
		
		private function initGameControllers():void
		{
			//queueNewState( GameState.CREATE_NEW_GAME );
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
		
		private function onPerformActionRequest(e:ViewEvent):void
		{
			switch( e.action )
			{
				case ViewEvent.NEW_LOCAL_MULTIPLAYER_GAME:
					queueNewState( GameState.CREATE_NEW_GAME );
					break;
				case ViewEvent.REFLOW_LAYOUT:
					_viewContainer.reflowLayout();
					break;
			}
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