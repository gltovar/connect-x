package view
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Sprite;
	
	public class Cell extends Sprite
	{
		/*private var _cell
		private var _cellWallB2BodyLeft:b2Body;
		private var _cellWallB2BodyRight:b2Body;
		private var _cellWallB2FixtureDefLeft:b2FixtureDef;
		private var _cellWallB2FixtureDefRight:b2FixtureDef;
		
		public function get cellWallB2BodyLeft():b2Body { return _cellWallB2BodyLeft; }
		public function get cellWallB2FixtureDefLeft():b2FixtureDef { return _cellWallB2FixtureDefLeft; }
		public function get cellWallB2BodyRight():b2Body { return _cellWallB2BodyRight; }
		public function get cellWallB2FixtureDefRight():b2FixtureDef { return _cellWallB2FixtureDefRight; }
		*/	
		
		public function Cell()
		{
			render();
			//initB2Items();
		}
		
		private function render():void
		{
			with( graphics )
			{
				lineStyle( 1, 0xFFFFFF );
				beginFill( 0xDDFFDD, 1 );
				drawRect( -12, -12, 24, 24);
				endFill();
			}
		}
		/*
		private function initB2Items():void
		{
			var shape:b2PolygonShape = new b2PolygonShape();
			var top:b2Vec2 = new b2Vec2();
			var bottom:b2Vec2 = new b2Vec2();
			
			
			top.Set(0, 0);
			bottom.Set(0, 1);
			shape.SetAsEdge( top, bottom );
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.
		}*/
	}
}