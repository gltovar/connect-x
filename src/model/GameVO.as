package model
{
	import interfaces.IModel;

	public class GameVO implements IModel
	{
		public static const PLAYERS_MIN:int = 2;
		public static const PLAYERS_MAX:int = 9;
		
		public static const ROWS_MAX:int = 20;
		
		public static const COLUMNS_MAX:int = 20;
		
		public static const WINNING_CONNECTION_QUANTITY_MIN:int = 3;
		public static const WINNING_CONNECTION_QUANTITY_MAX:int = 9;
		
		public function GameVO()
		{
		}
		
		private var _players:Vector.<PlayerVO>;
		private var _playerTurn:String;
		private var _pieces:Vector.<PieceVO>;
		private var _rows:int;
		private var _columns:int;
		private var _winningConnectionQuantity:int;
		
		public function get winningConnectionQuantity():int
		{
			return _winningConnectionQuantity;
		}
		public function set winningConnectionQuantity(value:int):void
		{
			value = Math.min( Math.max(value, WINNING_CONNECTION_QUANTITY_MIN), WINNING_CONNECTION_QUANTITY_MAX);
			_winningConnectionQuantity = value;
		}

		public function get players():Vector.<PlayerVO>
		{
			return _players;
		}
		public function set players(value:Vector.<PlayerVO>):void
		{
			_players = value;
		}

		public function get playerTurn():String
		{
			return _playerTurn;
		}
		public function set playerTurn(value:String):void
		{
			_playerTurn = value;
		}

		public function get pieces():Vector.<PieceVO>
		{
			return _pieces;
		}
		public function set pieces(value:Vector.<PieceVO>):void
		{
			_pieces = value;
		}

		public function get rows():int
		{
			return _rows;
		}
		public function set rows(value:int):void
		{
			value = Math.min( Math.max(value, WINNING_CONNECTION_QUANTITY_MIN), ROWS_MAX )
			_rows = value;
		}

		public function get columns():int
		{
			return _columns;
		}
		public function set columns(value:int):void
		{
			value = Math.min( Math.max(value, WINNING_CONNECTION_QUANTITY_MIN), COLUMNS_MAX );
			_columns = value;
		}

		public function toGenericObject():Object
		{
			
			return new Object;
		}
	}
}