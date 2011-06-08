package view
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Sprite;
	
	import model.PieceVO;
	
	/**
	 * This is the piece graphics. 
	 * @author gltovar85
	 * 
	 */
	public class Piece extends Sprite
	{
		public static const RADIUS:Number = 10;
		
		private var _pieceColor:uint;
		private var _pieceB2Body:b2Body;
		private var _pieceB2FixtureDef:b2FixtureDef
		private var _pieceB2BodyDef:b2BodyDef;
		
		private var _pixelsPerMeter:Number = 30;
		
		public function set pieceB2Body(value:b2Body):void
		{
			_pieceB2Body = value;
		}
		public function get pieceB2Body():b2Body { return _pieceB2Body; } 
		public function get pieceB2FixtureDef():b2FixtureDef { return _pieceB2FixtureDef; }
		public function get pieceB2BodyDef():b2BodyDef { return _pieceB2BodyDef; }
		
		private var _pieceVO:PieceVO;
		
		public function Piece(p_pieceVO:PieceVO)
		{
			switch( int(p_pieceVO.pieceOwnerId) )
			{
				case 0:
					_pieceColor = 0xFF0000;
					break;
				case 1:
					_pieceColor = 0x0000FF;
					break;
				case 2:
					_pieceColor = 0xFF00FF;
					break;
				case 3:
					_pieceColor = 0x00FF00;
					break;
				case 4:
					_pieceColor = 0x00FFFF;
					break;
				default:
					_pieceColor = 0;
					break;
			}
			
			render();
			initPieceFixture();
		}
		
		private function render():void
		{
			with(graphics)
			{
				beginFill( _pieceColor, 1 );
				drawCircle( 0,0, 10 );  // TODO this will be replaced by graphics, hate magic numbers
				endFill();
			}
		}
		
		private function initPieceFixture():void
		{
			
			var shape:b2CircleShape = new b2CircleShape( RADIUS / _pixelsPerMeter );
			
			
			_pieceB2BodyDef = new b2BodyDef();
			_pieceB2BodyDef.type = b2Body.b2_dynamicBody;
			_pieceB2BodyDef.userData = this;
			
			_pieceB2FixtureDef = new b2FixtureDef();
			_pieceB2FixtureDef.shape = shape;
			_pieceB2FixtureDef.density = 1;
			_pieceB2FixtureDef.friction = 0.5;
			_pieceB2FixtureDef.restitution = 0.2;
			
		}
		
	}
}