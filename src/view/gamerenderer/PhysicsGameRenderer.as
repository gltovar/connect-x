package view.gamerenderer
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import view.GameLayer;
	
	public class PhysicsGameRenderer extends EventDispatcher
	{
		private var _gameLayer:GameLayer;
		
		public function PhysicsGameRenderer(p_gameLayer:GameLayer)
		{
			_gameLayer = p_gameLayer;
		}
	}
}