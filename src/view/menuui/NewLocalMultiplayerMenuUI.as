package view.menuui
{
	import com.bit101.components.PushButton;
	
	import event.MenuUIEvent;
	import event.ViewEvent;
	
	import flash.events.MouseEvent;
	
	import model.GameVO;
	
	public class NewLocalMultiplayerMenuUI extends AbstractMenuUI
	{
		public function NewLocalMultiplayerMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
		}
		
		override protected function initialize():void
		{
			var xml:XML = 	<comps>
	<Panel id="newLocalMultiplayerGameMenu" x="-60" y="-100" width="120" height="200">
								    <VBox x="10" y="5">
								        <Label x="0" text="Local Multiplayer Game" />
								        <HBox>
								            <InputText id="newPlayerName" width="65" height="20" />
											<PushButton id="addPlayer" width="30" label="oust" />
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
			
			var btn:PushButton = _config.getCompById( 'startNewLocalMultiplayerGame' ) as PushButton;
			btn.addEventListener( MouseEvent.CLICK, onStartNewGameClick, false, 0, true);
		}
		
		private function onStartNewGameClick(e:MouseEvent):void
		{
			dispatchEvent( new MenuUIEvent( MenuUIEvent.NAVIGATE, MenuUIEvent.TO_HIDDEN) );
			dispatchEvent( new ViewEvent( ViewEvent.PERFORM_ACTION, ViewEvent.NEW_LOCAL_MULTIPLAYER_GAME ) );
		}
	}
}