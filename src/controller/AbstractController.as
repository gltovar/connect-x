package controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import interfaces.IController;
	import interfaces.IModel;
	import interfaces.IView;
	
	import model.GameState;
	
	public class AbstractController extends EventDispatcher implements IController
	{
		public function get gameState():GameState{ return null };
		
		public function AbstractController(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private var _view:IView;
		private var _model:IModel;
		
		public function initController(p_view:IView, p_model:IModel):void
		{
			
		}
		
		public function startController():void
		{
		}
		
		public function stopController():void
		{
		}
	}
}