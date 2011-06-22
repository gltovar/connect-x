package view
{
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import interfaces.IView;
	
	import model.GameVO;
	import model.PlayerVO;
	import model.ViewLayoutVO;
	
	import view.hudui.PlayerBadge;
	
	public class HUDLayer extends Sprite implements IView
	{
		
		private var _hudContainer:Sprite;
		private var _hudBackground:Panel
		
		private var _playerBadges:Vector.<PlayerBadge>;
		
		private var _viewLayoutVOs:Vector.<ViewLayoutVO>;
		public function get viewLayoutVOs():Vector.<ViewLayoutVO> { return _viewLayoutVOs; }
		
		private var _gameVO:GameVO;
		
		public function HUDLayer( p_gameVO:GameVO )
		{
			super();
			_viewLayoutVOs = new Vector.<ViewLayoutVO>;
			_viewLayoutVOs.push( new ViewLayoutVO( ViewLayoutVO.LAYOUT_ORIENTATION_HORIZONTAL, 0, 0, .25, 1 ) );
			_viewLayoutVOs.push( new ViewLayoutVO( ViewLayoutVO.LAYOUT_ORIENTATION_VERTICAL, 0, 0, 1, .25 ) );
			
			_gameVO = p_gameVO;
			
			initHUD();
		}
		
		public function initHUD():void
		{
			_hudContainer = new Sprite();
			
			_hudBackground = new Panel( _hudContainer, 0,0 );
			
			addChild( _hudContainer );
			
			_hudContainer.addChild( _hudBackground );
			
			_playerBadges = new Vector.<PlayerBadge>;
			
			var playerBadge:PlayerBadge;
			var playerVO:PlayerVO;
			for each( playerVO in _gameVO.players )
			{
				playerBadge = new PlayerBadge( playerVO );
				_playerBadges.push( playerBadge );
				addChild( playerBadge );
			}
			
			
		}
		
		public function asDisplayObject():DisplayObject { return this; }
		
		public function reflowView(p_viewLayoutVO:ViewLayoutVO):void
		{
			/*if(_hudBackground)
			{
				_hudContainer.removeChild( _hudBackground );
				_hudBackground = null;
			}*/
			
			//_hudBackground = new Panel( _hudContainer, 0, 0 );
			_hudBackground.width = p_viewLayoutVO.width;
			_hudBackground.height = p_viewLayoutVO.height;
			
			_hudContainer.x = p_viewLayoutVO.x;
			_hudContainer.y = p_viewLayoutVO.y;
			
			var playerBadge:PlayerBadge;
			for each( playerBadge in _playerBadges )
			{
				playerBadge.reflowPlayerBadge( p_viewLayoutVO.orientation );
			}
			
			//_hudContainer.addChild( _hudBackground );
		}
	}
}