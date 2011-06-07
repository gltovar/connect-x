package controller
{
	import event.ControllerEvent;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import interfaces.IController;
	import interfaces.IModel;
	import interfaces.IView;
	
	import model.GameState;
	import model.GameVO;
	import model.PieceVO;
	import model.PlayerVO;
	
	import view.MenuLayer;

	public class CreateNewGame extends AbstractController
	{
		override public function get gameState():GameState {return GameState.CREATE_NEW_GAME;}
		
		public function CreateNewGame()
		{
			
		}
		
		private var _gameVO:GameVO;
		private var _menuLayer:MenuLayer;
		
		
		override public function initController(p_view:IView, p_model:IModel):void
		{
			if( p_view is MenuLayer && p_model is GameVO)
			{
				_gameVO = p_model as GameVO;
				_menuLayer = p_view as MenuLayer;
			}
			else
			{
				throw Error( "Incorrect types of view or model passed into CreateNewGame Controller" );
			}
		}
		
		override public function startController():void
		{
			_gameVO.rows = 10;
			_gameVO.columns = 12;
			_gameVO.winningConnectionQuantity = 5;
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
			
			var piece:PieceVO;
			var i:int = _gameVO.rows * _gameVO.columns;
			while( i >= 0 )
			{
				piece = new PieceVO();
				piece.pieceId = i.toString();
				piece.pieceOwnerId = String( i%2 );
				_gameVO.players[ i%2 ].pieces.push(piece.pieceId);
				//piece.piecePosition = new Point( int( Math.random() * (_gameVO.columns - .01) ), int( Math.random() * (_gameVO.rows - .01) ) );
				piece.piecePosition = new Point(-1,-1);
				_gameVO.pieces.push( piece );
				
				trace( piece.piecePosition.toString() );
				
				i--;
			}
			
			dispatchEvent( new ControllerEvent( ControllerEvent.QUEUE_GAME_STATE, GameState.RUNNING_LOCAL_MULTIPLAYER_GAME ) );
			
			dispatchEvent( new ControllerEvent( ControllerEvent.COMPLETE ) );
			
		}
		
		override public function stopController():void
		{
			
		}

	}
}