package model
{
	import flash.geom.Point;
	
	import interfaces.IModel;

	public class PieceVO implements IModel
	{
		public function PieceVO()
		{
		}
		
		private var _pieceId:String;
		private var _pieceOwnerId:String;
		private var _piecePosition:Point = new Point (-1, -1);
		
		public function get pieceId():String
		{
			return _pieceId;
		}
		public function set pieceId(value:String):void
		{
			_pieceId = value;
		}

		
		public function get pieceOwnerId():String
		{
			return _pieceOwnerId;
		}
		public function set pieceOwnerId(value:String):void
		{
			_pieceOwnerId = value;
		}
		
		
		public function get piecePosition():Point
		{
			return _piecePosition;
		}
		public function set piecePosition(value:Point):void
		{
			_piecePosition = value;
		}

		
		public function toGenericObject():Object
		{
			return new Object;
		}
	}
}