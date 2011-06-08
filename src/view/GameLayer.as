package view
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import com.bit101.components.Label;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import interfaces.IView;
	
	import model.GameVO;
	import model.PieceVO;
	
	import view.gamerenderer.PhysicsGameRenderer;

	/**
	 * This View is strictly for game field graphics. By keeping the method calls to this
	 * very generic, I can create creating different view interpretations (physics based or tween based) 
	 * @author gltovar85
	 * 
	 */
	public class GameLayer extends Sprite implements IView
	{
		private var _boardContainer:Sprite;
		private var _piecesLayer:Sprite;
		private var _cellsLayer:Sprite;
		
		private var _rowHeight:Number = 20;
		private var _columnWidth:Number = 30;
		
		private var _rowOffset:Number = 10;
		private var _columnOffset:Number = 10;
		
		private var _world:b2World;
		private var _velocityIterations:int = 10;
		private var _positionIterations:int = 10;
		private var _timeStep:Number = 1.0/30.0;
		private var _pixelsPerMeter:Number = 30;
		
		private var _debugSprite:Sprite;
		
		private var _gameVO:GameVO;
		
		private var _outputLabel:Label;
		
		public function GameLayer(p_gameVO:GameVO)
		{
			_gameVO = p_gameVO;
			addEventListener( Event.ADDED_TO_STAGE, initLayers );
		}
		
		private function initLayers(e:Event):void
		{
			_boardContainer = new Sprite();
			_cellsLayer = new Sprite();
			_piecesLayer = new Sprite();
			_debugSprite = new Sprite();
			_outputLabel = new Label();
			
			addChild( _boardContainer );
			_boardContainer.addChild( _cellsLayer );
			_boardContainer.addChild( _piecesLayer );
			addChild( _outputLabel );
			
			_outputLabel.text = "";
			
			_boardContainer.y = 25;
			
			
			
			//initPhysics();
		}
		
		private function initPhysics():void
		{
			addEventListener( Event.ENTER_FRAME, physicsWorldStep, false, 0, false );
			
			// Define gravity
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// allow bodies to sleep
			var doSleep:Boolean = true;
			
			// construct a world object
			_world = new b2World( gravity, doSleep );
			_world.SetWarmStarting( true );
			
			
			
			// set debug draw
			/*var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite( _debugSprite );
			debugDraw.SetDrawScale( 1 );
			debugDraw.SetFillAlpha( .5 );
			debugDraw.SetLineThickness( 1.0 );
			debugDraw.SetFlags( b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			_world.SetDebugDraw( debugDraw );
			_world.DrawDebugData();*/
			
			
		}
		
		public function physicsWorldStep(e:Event = null):void
		{
			_world.Step( _timeStep, _velocityIterations, _positionIterations );
			_world.ClearForces();
			//_world.DrawDebugData();
			
			
			for( var bb:b2Body = _world.GetBodyList(); bb; bb = bb.GetNext() )
			{
				if (bb.GetUserData() is Sprite){
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * _pixelsPerMeter;
					sprite.y = bb.GetPosition().y * _pixelsPerMeter;
					sprite.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}
		}
		
		public function drawCell( p_cellArt:DisplayObject, p_column:Number, p_row:Number ):void
		{
			trace( 'at draw cell' );
			_cellsLayer.addChild( p_cellArt );
			p_cellArt.x = p_column * _columnWidth + _columnOffset;
			p_cellArt.y = p_row * _rowHeight + _rowOffset;
			
			
		}
		
		public function setGameBounds():void
		{
			initPhysics();
			drawPieceBounds();
		}
		
		private function drawPieceBounds():void
		{
			
			var body:b2Body;
			var bodyDef:b2BodyDef;
			var boxShape:b2PolygonShape;
			var fixtureDef:b2FixtureDef;
			var plainSprite:Sprite
			
			plainSprite = new Sprite();
			plainSprite.graphics.beginFill(0);
			plainSprite.graphics.drawRect(-.5, -.5, 1, 1);
			
			// add ground body
			bodyDef = new b2BodyDef();
			bodyDef.position.Set((_gameVO.columns * _columnWidth * .5) / _pixelsPerMeter, (_gameVO.rows * _rowHeight) / _pixelsPerMeter);
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox( ((_gameVO.columns * _columnWidth)*.5) / _pixelsPerMeter, .1) ;
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.3;
			fixtureDef.density = 0; // static bodies require zero density
			
			// add sprite to body userData
			bodyDef.userData = plainSprite;
			bodyDef.userData.width = (_gameVO.columns * _columnWidth); 
			bodyDef.userData.height =  .1 * 30;
			_boardContainer.addChild(bodyDef.userData);
			
			body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			
			var i:int;
			for( i=0; i < _gameVO.columns+1; i++ )
			{
			
				plainSprite = new Sprite();
				plainSprite.graphics.beginFill(0);
				plainSprite.graphics.drawRect(-.5, -.5, 1, 1);
				
				// add left side
				bodyDef = new b2BodyDef();
				bodyDef.position.Set( (i * _columnWidth - 5) / _pixelsPerMeter, (_gameVO.rows * _rowHeight * .5) / _pixelsPerMeter);
				boxShape = new b2PolygonShape();
				boxShape.SetAsBox(.1, ((_gameVO.rows * _rowHeight)*.5) / _pixelsPerMeter) ;
				fixtureDef = new b2FixtureDef();
				fixtureDef.shape = boxShape;
				fixtureDef.friction = 0.3;
				fixtureDef.density = 0; // static bodies require zero density
				
				// add sprite to body userData
				bodyDef.userData = plainSprite;
				bodyDef.userData.width = .1 * 30; 
				bodyDef.userData.height =  (_gameVO.rows * _rowHeight);
				_boardContainer.addChild(bodyDef.userData);
				
				body = _world.CreateBody(bodyDef);
				body.CreateFixture(fixtureDef);
			}
			
			ReflowLayout();
		}
		
		public function drawPiece( p_pieceArt:PieceVO,  p_column:Number, p_row:Number ):void
		{
			
			trace( 'at draw piece' );
			var piece:Piece = new Piece( p_pieceArt );
			
			piece.pieceB2BodyDef.position.x = ( (p_column * _columnWidth) + ( Piece.RADIUS + (Math.random()*2) ) - 1  ) / _pixelsPerMeter;
			piece.pieceB2BodyDef.position.y = -20 / _pixelsPerMeter;
			piece.pieceB2Body = _world.CreateBody( piece.pieceB2BodyDef );
			piece.pieceB2Body.CreateFixture( piece.pieceB2FixtureDef );
				
			_piecesLayer.addChild( piece );
			piece.x = -500
			piece.y = -500;
		}
		
		public function ReflowLayout():void
		{
			var bounds:Rectangle = this.getBounds(this);
			trace("gameUI:" + this.getBounds(this));
			
			
			
			this.scaleX = this.scaleY =   (stage.stageWidth * .8)  / (bounds.width) ;
			
			bounds = this.getBounds(this);
			
			if(  ( bounds.height ) > (stage.stageHeight* .8)  )
			{
				this.scaleY = this.scaleX =  (stage.stageHeight * .8) / (bounds.height) ;
			}
			
			this.x = stage.stageWidth/2 - (bounds.width * this.scaleX)/2
			this.y = stage.stageHeight/2 - (bounds.height * this.scaleY)/2
			
			//_boardContainer.x = stage.stageWidth/2 - (bounds.width * _boardContainer.scaleX)/2;
			//_boardContainer.y = stage.stageHeight/2 - (bounds.height * _boardContainer.scaleY)/2;
		}
		
		public function updateOutputLabel(p_output:String):void
		{
			if( _outputLabel.text.search('won!') == -1 )
			{
				_outputLabel.text = p_output;
			}
		}
	}
}