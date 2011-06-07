package model
{
	import interfaces.IModel;

	public class GameVO implements IModel
	{
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
			_rows = value;
		}

		public function get columns():int
		{
			return _columns;
		}
		public function set columns(value:int):void
		{
			_columns = value;
		}

		public function toGenericObject():Object
		{
			
			return new Object;
		}
	}
}