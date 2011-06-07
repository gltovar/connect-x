package view
{
	import flash.display.Sprite;
	
	/**
	 * This is the piece graphics. 
	 * @author gltovar85
	 * 
	 */
	public class Piece extends Sprite
	{
		private var _pieceColor:uint;
		
		public function Piece(p_playerPieceType:int)
		{
			switch( p_playerPieceType)
			{
				case 0:
					_pieceColor = 0xFF0000;
					break;
				case 1:
					_pieceColor = 0x0000FF;
					break;
				default:
					_pieceColor = 0;
					break;
			}
			
			render();
		}
		
		public function render():void
		{
			with(graphics)
			{
				beginFill( _pieceColor, 1 );
				drawCircle( 0,0, 10 );  // TODO this will be replaced by graphics, hate magic numbers
				endFill();
			}
		}
	}
}