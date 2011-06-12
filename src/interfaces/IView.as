package interfaces
{
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	
	import model.ViewLayoutVO;

	public interface IView
	{
		function get viewLayoutVOs():Vector.<ViewLayoutVO>;
		function asDisplayObject():DisplayObject;
		function reflowView(p_viewLayoutVo:ViewLayoutVO):void;
	}
}