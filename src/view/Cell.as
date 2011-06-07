package view
{
	import flash.display.Sprite;
	
	public class Cell extends Sprite
	{
		public function Cell()
		{
			render();
		}
		
		private function render():void
		{
			with( graphics )
			{
				lineStyle( 1, 0xFFFFFF );
				beginFill( 0x005500, 1 );
				drawRect( -10, -10, 20, 20);
				endFill();
			}
		}
	}
}