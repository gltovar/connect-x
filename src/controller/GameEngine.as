package controller
{
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Window;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import interfaces.IController;
	
	import model.GameVO;
	import model.PieceVO;
	import model.PlayerVO;
	
	import view.Cell;
	import view.GameLayer;
	import view.Piece;

	public class GameEngine extends EventDispatcher
	{
		// passed in
		private var _gameLayer:GameLayer;
		private var _gameVO:GameVO;
		
		private var _boardGrid:Array;
		private var _winMap:Array;
		
		private var _magicWinNumber:int;
		private var _winPlaces:int;
		private var _piecesOnBoard:int;
		
		/**
		 * The heart of the game. 
		 * Would like to thank Keith Pomakis for his outstanding connect [x] algorithm.
		 * The way I would have figure it out would have sucked compared to it: 
		 * http://www.pomakis.com/c4/connect_generic/  (source is c code)
		 * 
		 * @param p_gameLayer
		 * @param p_gameVO
		 * 
		 */		
		public function GameEngine(p_gameLayer:GameLayer, p_gameVO:GameVO)
		{
			_gameLayer = p_gameLayer;
			_gameVO = p_gameVO;
			
			initializeGameState();
		}
		
		
		
		private function initializeGameState():void
		{	
			_magicWinNumber = 1 << _gameVO.winningConnectionQuantity;
			_winPlaces = calculateAmountOfWinningCombinations( _gameVO.columns, _gameVO.rows, _gameVO.winningConnectionQuantity );
		
			// init grid
			_boardGrid = [];
			var row:int = 0;
			var column:int = 0;
			while( column < _gameVO.columns )
			{
				if( _boardGrid.length == column){ _boardGrid.push( [] ) }
				while( row < _gameVO.rows )
				{
					_boardGrid[column].push('-1');
					row++;
				}
				row = 0;
				column++
			}
			
			var i:int = 0;
			var player:PlayerVO;
			for each( player in _gameVO.players )
			{
				player.scoreArray = [];
				
				while( i < _winPlaces )
				{
					player.scoreArray[i] = 1;
					i++;
				}
				i = 0;
				
				player.scoreArray[0] = _winPlaces;
				player.score = _winPlaces;
			}
			
			_piecesOnBoard = 0;
			
			// setup map
			_winMap = new Array( _gameVO.columns);
			var j:int;
			for( i=0; i < _gameVO.columns; i++ )
			{
				_winMap[i] =  new Array(  _gameVO.rows ) ;
				for( j=0; j < _gameVO.rows; j++)
				{
					_winMap[i][j] = new Array( (_gameVO.winningConnectionQuantity * 4 + 1) );
					_winMap[i][j][0] = -1;
				}
			}
			
			var winIndex:int = 0;
			var winIndices:Array;
			
			// fill in the horizontal win positions
			
			var k:int;
			var x:int;
			for( i=0; i < _gameVO.rows; i++ )
			{
				for( j=0; j < _gameVO.columns - _gameVO.winningConnectionQuantity + 1; j++) 
				{
					for( k=0; k < _gameVO.winningConnectionQuantity; k++)
					{
						winIndices = _winMap[j+k][i];
						for( x=0; winIndices[x] != -1; x++) {/* empty set*/}
							 
						winIndices[x++] = winIndex;
						winIndices[x] = -1;
					}
					winIndex++;
				}
			}
			
			// fill in vertical win positions
			for( i=0; i < _gameVO.columns; i++ )
			{
				for( j=0; j < _gameVO.rows - _gameVO.winningConnectionQuantity+1; j++)
				{
					for( k=0; k < _gameVO.winningConnectionQuantity; k++ )
					{
						winIndices = _winMap[i][j+k];
						for( x=0; winIndices[x] != -1; x++ ) {/* empty set */}
						
						winIndices[x++] = winIndex;
						winIndices[x] = -1;
					}
					winIndex++;
				}
			}
			
			// Fill in the forward diagonal win positions
			for( i=0; i < _gameVO.rows - _gameVO.winningConnectionQuantity + 1; i++ )
			{
				for( j=0; j < _gameVO.columns - _gameVO.winningConnectionQuantity + 1; j++ )
				{
					for( k=0; k < _gameVO.winningConnectionQuantity; k++ )
					{
						winIndices = _winMap[j+k][i+k];
						for( x=0; winIndices[x] != -1; x++) { /*empty set*/ }
						
						winIndices[x++] = winIndex;
						winIndices[x] = -1;
					}
					winIndex++;
				}
			}
			
			// Fill in the backward diagonal win positions  THIS ONE IS REALLY DIFFERENT
			for( i=0; i < _gameVO.rows - _gameVO.winningConnectionQuantity + 1; i++ )
			{
				for( j = _gameVO.columns - 1; j >= _gameVO.winningConnectionQuantity-1; j-- )
				{
					for( k=0; k < _gameVO.winningConnectionQuantity; k++ )
					{
						winIndices = _winMap[j-k][i+k];
						for( x=0; winIndices[x] != -1; x++) { /*empty set*/ }
						
						winIndices[x++] = winIndex;
						winIndices[x] = -1;
					}
					winIndex++;
				}
			}
			
			render();
		}
		
		private function render():void
		{
			var row:int = 0;
			var column:int = 0;
			var cellArt:Cell;
			
			while( column < _gameVO.columns )
			{
				while( row < _gameVO.rows )
				{
					_gameLayer.drawCell( new Cell(), column, row );
					
					row++;
				}
				row = 0;
				column++;
			}
			
			_gameLayer.setGameBounds();
		}
		
		
		/**
		 * each _winMap[x][y] contains the index for the player.scoreArray where 
		 * a player having a piece there would win in every index of the _winMap.
		 * This cycles though all the values in the _winMap[x][y] and adds one (bitwise)
		 * to the player's scoreArray _winMap[x][y][cycle] and if it detects that the player
		 * has a score in their _scoreArray that == the amount needed to win, then they have won. 
		 * @param p_pieceVO
		 * 
		 */
		private function updateScore(p_pieceVO:PieceVO):void
		{
			var i:int;
			var winIndex:int;
			
			var playerVO:PlayerVO;

			for( i=0; _winMap[ p_pieceVO.piecePosition.x ][ p_pieceVO.piecePosition.y ][ i ] != -1; i++ )
			{
				winIndex = _winMap[ p_pieceVO.piecePosition.x ][ p_pieceVO.piecePosition.y ][ i ];
				for each( playerVO in _gameVO.players )
				{
							
					if(playerVO.playerId == p_pieceVO.pieceOwnerId)
					{
						playerVO.score += playerVO.scoreArray[ winIndex ];
						playerVO.scoreArray[ winIndex ] <<= 1;
					}
					else
					{
						playerVO.score -= playerVO.scoreArray[ winIndex ];
						playerVO.scoreArray[ winIndex ] = 0;
					}
					
					if( playerVO.scoreArray[winIndex] == _magicWinNumber )
					{
						/// WINNER!
						trace('found a winner!');
						_gameLayer.updateOutputLabel( _gameVO.players[int(p_pieceVO.pieceOwnerId)].playerName + " has won!");
					}
				}
			}
		}
		
		public function addPieceToSlot(p_pieceId:String, p_slotColumn:int):void
		{
			var pieceVO:PieceVO = getPieceFromId(p_pieceId);
			
			var row:int = -1;
			
			while( row+1 < _boardGrid[p_slotColumn].length && _boardGrid[p_slotColumn][row+1] == '-1' )
			{
				row++;
			}
			
			if( row > -1 )
			{
				pieceVO.piecePosition.x = p_slotColumn;
				pieceVO.piecePosition.y = row;
				_boardGrid[p_slotColumn][row] = pieceVO.pieceOwnerId;
				_piecesOnBoard++;
				updateScore( pieceVO );
				_gameLayer.drawPiece( pieceVO, p_slotColumn, row );
			}
			else
			{
				trace( 'slot is full, try another' );
			}
		}
		
		private function getPieceFromId(p_pieceId:String):PieceVO
		{
			var result:PieceVO;
			for each( result in _gameVO.pieces)
			{
				if( result.pieceId == p_pieceId)
				{
					break;
				}
			}
			
			return result;
		}
		
		private function getPlayerFromId(p_playerId:String):PlayerVO
		{
			var result:PlayerVO = null;
			
			var playerVO:PlayerVO;
			for each( playerVO in _gameVO.players )
			{
				if( playerVO.playerId == p_playerId )
				{
					result = playerVO;
				}
			}
			
			return result;
		}
		
		private static function calculateAmountOfWinningCombinations( p_columns:int, p_rows:int, p_connectionAmount:int ):int
		{
			var result:int = 0;
			
			if( p_columns < p_connectionAmount && p_rows < p_connectionAmount )
			{
				result = 0;	
			}
			else if( p_columns < p_connectionAmount )
			{
				result = p_columns * ( (p_rows - p_connectionAmount ) + 1 );
			}
			else if( p_rows < p_connectionAmount )
			{
				result = p_rows * ( (p_columns - p_connectionAmount) + 1 );
			}
			else
			{
				result =	4 * p_columns * p_rows -
							3 * p_columns * p_connectionAmount -
							3 * p_rows * p_connectionAmount +
							3 * p_columns +
							3 * p_rows -
							4 * p_connectionAmount +
							2 * p_connectionAmount * p_connectionAmount +
							2;
			}
			
			return result;
		}
	}
}