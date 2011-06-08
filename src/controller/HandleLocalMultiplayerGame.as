package controller
{
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import interfaces.IController;
	import interfaces.IModel;
	import interfaces.IView;
	
	import model.GameState;
	import model.GameVO;
	import model.PlayerVO;
	
	import view.GameLayer;

	/**
	 * This control wraps the AbstractGameEngine for strictly local multiplayer play. 
	 * @author gltovar85
	 * 
	 */
	public class HandleLocalMultiplayerGame extends AbstractController
	{
		override public function get gameState():GameState { return GameState.RUNNING_LOCAL_MULTIPLAYER_GAME; }
		
		private var _gameVO:GameVO;
		private var _gameLayer:GameLayer;
		
		private var _abstractGameEngine:GameEngine;
		private var _playerTurnOrder:Vector.<PlayerVO>;
		
		public function HandleLocalMultiplayerGame()
		{
			//empty set
		}
		
		override public function initController(p_view:IView, p_model:IModel):void
		{
			if( p_view is GameLayer && p_model is GameVO )
			{
				_gameVO = p_model as GameVO;
				_gameLayer = p_view as GameLayer;
			}
			else
			{
				throw Error( "Incorrect class type passed into the start controller" );
			}
		}
		
		override public function startController():void
		{
			_playerTurnOrder = new Vector.<PlayerVO>;
			
			var player:PlayerVO;
			for each (player in _gameVO.players)
			{
				_playerTurnOrder.push(player);
			}
			
			
			_abstractGameEngine = new GameEngine(_gameLayer, _gameVO);
			_gameLayer.addEventListener( MouseEvent.CLICK, onMouseClick, false, 0, true );
			_gameLayer.updateOutputLabel( _playerTurnOrder[0].playerName + "'s turn");
		}
		
		
		private var _lastClick:Number = 0;
		private var _minimumWaitTime:Number = 200;
		/**
		 * The controller should not be dealing with UI like this... very ugly stuff right here
		 * @param e
		 * 
		 */		
		private function onMouseClick(e:MouseEvent):void
		{
			trace( _lastClick + _minimumWaitTime + " " + getTimer() );
			if(_lastClick+_minimumWaitTime < getTimer() )
			{
				//trace( int(_gameLayer.mouseX/20) + ", " + int(_gameLayer.mouseY/20) );
				
				_abstractGameEngine.addPieceToSlot(_playerTurnOrder[0].pieces.shift(), int(_gameLayer.mouseX/ 30) );
				
				_playerTurnOrder.push(_playerTurnOrder.shift());
				_gameLayer.updateOutputLabel( _playerTurnOrder[0].playerName + "'s turn");
				_lastClick = getTimer();
			}
		}
		
		override public function stopController():void
		{
			
		}
	}
}