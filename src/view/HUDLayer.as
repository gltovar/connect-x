package view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import interfaces.IView;
	
	import model.ViewLayoutVO;
	
	public class HUDLayer extends Sprite implements IView
	{
		
		private var _viewLayoutVOs:Vector.<ViewLayoutVO>;
		public function get viewLayoutVOs():Vector.<ViewLayoutVO> { return _viewLayoutVOs; }
		
		public function HUDLayer()
		{
			super();
			_viewLayoutVOs = new Vector.<ViewLayoutVO>;
			_viewLayoutVOs.push( new ViewLayoutVO( ViewLayoutVO.LAYOUT_ORIENTATION_HORIZONTAL, 0, 0, .25, 1 ) );
			_viewLayoutVOs.push( new ViewLayoutVO( ViewLayoutVO.LAYOUT_ORIENTATION_VERTICAL, 0, 0, 1, .25 ) );
		}
		
		public function asDisplayObject():DisplayObject { return this; }
		
		public function reflowView(p_viewLayoutVO:ViewLayoutVO):void
		{
			
		}
	}
}