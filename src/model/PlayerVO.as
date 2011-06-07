package model
{
	import interfaces.IModel;

	public class PlayerVO implements IModel
	{
		public static const PLAYER_NAME_MIN:int = 3;
		public static const PLAYER_NAME_MAX:int = 10;
		
		public function PlayerVO()
		{
			// empty set
		}
		
		private var _playerId:String;
		private var _playerName:String;
		private var _pieces:Vector.<String>;
		private var _scoreArray:Array;
		private var _score:int;
		
		public function get score():int
		{
			return _score;
		}
		public function set score(value:int):void
		{
			_score = value;
		}

		public function get scoreArray():Array
		{
			return _scoreArray;
		}
		public function set scoreArray(value:Array):void
		{
			_scoreArray = value;
		}

		public function get playerId():String
		{
			return _playerId;
		}
		public function set playerId(value:String):void
		{
			_playerId = value;
		}

		public function get playerName():String
		{
			return _playerName;
		}
		public function set playerName(value:String):void
		{
			_playerName = value;
		}

		public function get pieces():Vector.<String>
		{
			return _pieces;
		}
		public function set pieces(value:Vector.<String>):void
		{
			_pieces = value;
		}

		public function toGenericObject():Object
		{
			// need to clone to generic object for saving and transmition (private vars killed in process)
			
			return new Object;
		}
	}
}