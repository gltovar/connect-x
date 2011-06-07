package view.menuui
{
	import com.bit101.components.InputText;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	
	import event.MenuUIEvent;
	import event.ViewEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.GameVO;
	import model.PlayerVO;
	
	public class NewLocalMultiplayerMenuUI extends AbstractMenuUI
	{
		private static const FULL:String = "FULL" ;
		private static const KICK:String = 'Kick';
		private static const ADD:String = 'Add';
		
		//private var _playerNameList:Array;
		
		private var _inputTextPlayerName:InputText;
		private var _pushButtonAddRemovePlayer:PushButton;
		private var _listPlayerNames:List;
		private var _pushButtonStartNewLocalMultiplayerGame:PushButton;
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			
			setVOValues();
		}
		
		public function NewLocalMultiplayerMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
			
			//getVOValues();
		}
		
		override protected function initialize():void
		{
			
			//_playerNameList = [];
			var xml:XML = 	<comps>
								<Panel id="newLocalMultiplayerGameMenu" x="-60" y="-100" width="120" height="200">
								    <VBox x="10" y="5">
								        <Label x="0" text="Local Multiplayer Game" />
								        <HBox>
								            <InputText id="newPlayerName" width="65" height="20" />
											<PushButton id="addRemovePlayer" width="30" label="Add" />
								        </HBox>
								        <List id="playerNames" width="100" height="60" />
								        <PushButton id="newLocalMultiplayerGameMenuToOptions" label="Options" />
										<PushButton id="startNewLocalMultiplayerGame" label="Start" />
								        <PushButton id="newLocalMultiplayerGameMenuToPrevious" label="Back" />
								    </VBox>
								</Panel>
							</comps>;
			
			render( xml );
		}
		
		override protected function render(p_xml:XML):void
		{
			super.render(p_xml);
			
			addNavigationPushButtonEventListenerFromPushButtonId( 'newLocalMultiplayerGameMenuToOptions' );
			addNavigationPushButtonEventListenerFromPushButtonId( 'newLocalMultiplayerGameMenuToPrevious' );
			
			_pushButtonStartNewLocalMultiplayerGame = _config.getCompById( 'startNewLocalMultiplayerGame' ) as PushButton;
			_pushButtonStartNewLocalMultiplayerGame.addEventListener( MouseEvent.CLICK, onStartNewGameClick, false, 0, true);
			
			_inputTextPlayerName = _config.getCompById( 'newPlayerName' ) as InputText;
			_pushButtonAddRemovePlayer = _config.getCompById( 'addRemovePlayer') as PushButton;
			_listPlayerNames = _config.getCompById( 'playerNames' ) as List;
			
			_inputTextPlayerName.addEventListener( Event.CHANGE, onInputTextPlayerNameChange, false, 0, true);
			_pushButtonAddRemovePlayer.addEventListener( MouseEvent.CLICK, onPushButtonAddRemovePlayerClick, false, 0, true);
			_listPlayerNames.addEventListener( MouseEvent.CLICK, onListPlayerNamesClick, false, 0, true);
			
			getVOValues();
		}
		
		private function onListPlayerNamesClick(e:MouseEvent):void
		{
			if( _listPlayerNames.selectedItem != null )
			{
				_inputTextPlayerName.text = _listPlayerNames.selectedItem.toString();
			}
			
			checkInputTextToList();
		}
		
		private function onPushButtonAddRemovePlayerClick(e:MouseEvent):void
		{
			if( _pushButtonAddRemovePlayer.label == KICK )
			{
				_listPlayerNames.removeItem( _listPlayerNames.selectedItem );
				_listPlayerNames.selectedIndex = -1;
			}
			else if( _pushButtonAddRemovePlayer.label == ADD )
			{
				_listPlayerNames.addItem( _inputTextPlayerName.text );
				_inputTextPlayerName.text = '';
			}
			
			setVOValues();
			getVOValues();
		}
		
		private function onInputTextPlayerNameChange(e:Event):void
		{	
			checkInputTextToList();
		}
		
		private function checkInputTextToList():void
		{
			_pushButtonStartNewLocalMultiplayerGame.enabled = true;
			
			
			if( _inputTextPlayerName.text.length < PlayerVO.PLAYER_NAME_MIN && !(_listPlayerNames.items.length > GameVO.PLAYERS_MAX) )
			{
				_pushButtonAddRemovePlayer.label = "+" + (PlayerVO.PLAYER_NAME_MIN - _inputTextPlayerName.text.length);
				_pushButtonAddRemovePlayer.enabled = false;
			}
			else if( _inputTextPlayerName.text.length > PlayerVO.PLAYER_NAME_MAX )
			{
				_pushButtonAddRemovePlayer.label = "-" + (_inputTextPlayerName.text.length - PlayerVO.PLAYER_NAME_MAX);
				_pushButtonAddRemovePlayer.enabled = false;
			}
			else if( _listPlayerNames.items.indexOf( _inputTextPlayerName.text ) != -1 )
			{
				_pushButtonAddRemovePlayer.label = KICK;
				_listPlayerNames.selectedItem = _inputTextPlayerName.text;
				_pushButtonAddRemovePlayer.enabled = true;
			}
			else
			{
				_pushButtonAddRemovePlayer.label = ADD;
				_listPlayerNames.selectedIndex = -1;
				_pushButtonAddRemovePlayer.enabled = true;
				if( _listPlayerNames.items.length > GameVO.PLAYERS_MAX  )
				{
					_pushButtonAddRemovePlayer.label = FULL;
					_pushButtonAddRemovePlayer.enabled = false;
				}
			}
			
			if( _listPlayerNames.items.length < GameVO.PLAYERS_MIN  )
			{
				_pushButtonStartNewLocalMultiplayerGame.enabled = false;
			}
		}
		
		private function onStartNewGameClick(e:MouseEvent):void
		{
			dispatchEvent( new MenuUIEvent( MenuUIEvent.NAVIGATE, MenuUIEvent.TO_HIDDEN) );
			dispatchEvent( new ViewEvent( ViewEvent.PERFORM_ACTION, ViewEvent.NEW_LOCAL_MULTIPLAYER_GAME ) );
		}
		
		private function setVOValues():void
		{
			_gameVO.players = new Vector.<PlayerVO>;
			
			var playerVO:PlayerVO
			var playerName:String;
			for each( playerName in _listPlayerNames.items )
			{
				playerVO = new PlayerVO;
				playerVO.playerName = playerName;
				playerVO.playerId = String( _gameVO.players.length );
				playerVO.pieces = new Vector.<String>;
				
				_gameVO.players.push( playerVO );
			}
		}
		
		private function getVOValues():void
		{
			_listPlayerNames.removeAll();
			var playerVO:PlayerVO;
			for each( playerVO in _gameVO.players )
			{
				_listPlayerNames.addItem( playerVO.playerName );
			}
			
			checkInputTextToList();
		}
	}
}