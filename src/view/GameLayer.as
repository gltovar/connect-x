package view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import interfaces.IView;

	/**
	 * This View is strictly for game field graphics. By keeping the method calls to this
	 * very generic, I can create creating different view interpretations (physics based or tween based) 
	 * @author gltovar85
	 * 
	 */
	public class GameLayer extends Sprite implements IView
	{
		
		private var _piecesLayer:Sprite;
		private var _cellsLayer:Sprite;
		
		private var _rowHeight:Number = 20;
		private var _columnWidth:Number = 20;
		
		private var _rowOffset:Number = 10;
		private var _columnOffset:Number = 10;
		
		public function GameLayer()
		{
			initLayers();
		}
		
		private function initLayers():void
		{
			_cellsLayer = new Sprite();
			_piecesLayer = new Sprite();
			
			addChild( _cellsLayer );
			addChild( _piecesLayer );
		}
		
		public function drawCell( p_cellArt:DisplayObject, p_column:Number, p_row:Number ):void
		{
			trace( 'at draw cell' );
			_cellsLayer.addChild( p_cellArt );
			p_cellArt.x = p_column * _columnWidth + _columnOffset;
			p_cellArt.y = p_row * _rowHeight + _rowOffset;
		}
		
		public function drawPiece( p_pieceArt:DisplayObject,  p_column:Number, p_row:Number ):void
		{
			trace( 'at draw piece' );
			_piecesLayer.addChild( p_pieceArt );
			p_pieceArt.x = p_column * _columnWidth + _columnOffset;
			p_pieceArt.y = p_row * _rowHeight + _rowOffset;
		}
	}
}