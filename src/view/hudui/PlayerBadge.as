package view.hudui
{
	import com.bit101.components.Label;
	
	import flash.display.Sprite;
	
	import model.PlayerVO;
	import model.ViewLayoutVO;
	
	public class PlayerBadge extends Sprite
	{
		
		private var _playerLabel:Label;
		private var _playerVO:PlayerVO;
		
		public function PlayerBadge( p_playerVO:PlayerVO )
		{
			_playerVO = p_playerVO;
			
			super();
			initBadge();
		}
		
		private function initBadge():void
		{
			_playerLabel = new Label( this, 0, 0, _playerVO.playerName );
			_playerLabel.autoSize = true;
		}
		
		public function reflowPlayerBadge( p_orientation:String ):void
		{
			var i:int;
			switch( p_orientation )
			{
				case ViewLayoutVO.LAYOUT_ORIENTATION_HORIZONTAL:

					_playerLabel.text = _playerVO.playerName.charAt(0);
					
					for( i = 1; i < _playerVO.playerName.length; i++ )
					{
						_playerLabel.text += ' '+_playerVO.playerName.charAt(i);
					}
					
					break;
				case ViewLayoutVO.LAYOUT_ORIENTATION_VERTICAL:
					
					_playerLabel.text = _playerVO.playerName.charAt(0);
					
					for( i = 1; i < _playerVO.playerName.length; i++ )
					{
						_playerLabel.text += '\n'+_playerVO.playerName.charAt(i);
					}
						
					break;
				default:
					throw Error(" Player badge received an unknown orientation: " + p_orientation );
					break;
			}
		}
	}
}