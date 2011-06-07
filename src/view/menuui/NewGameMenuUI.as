package view.menuui
{
	import model.GameVO;
	
	public class NewGameMenuUI extends AbstractMenuUI
	{
		public function NewGameMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
		}
		
		override protected function initialize():void
		{
			var xml:XML = 	<comps>
								<Panel id="newGameMenu" x="-60" y="-100" width="120" height="200">
							        <VBox x="10" y="25">
							            <Label x="25" text="New Game" />
							            <PushButton id="newGameMenuToNewSinglePlayerGameMenu" label="Single Player" />
							            <PushButton id="newGameMenuToNewLocalMultiplayerGameMenu" label="Local Multiplayer" />
							            <PushButton id="newGameMenuToNewOnlineMultiplayerGameMenu" label="Online Multiplayer" />
							            <PushButton id="newGameMenuToPreviousMenu" label="Back" />
							        </VBox>
							    </Panel>
							</comps>;
			
			render( xml );
		}
		
		override protected function render(p_xml:XML):void
		{
			super.render(p_xml);
			
			//addNavigationPushButtonEventListenerFromPushButtonId( 'newGameMenuToNewSinglePlayerGameMenu' );
			addNavigationPushButtonEventListenerFromPushButtonId( 'newGameMenuToNewLocalMultiplayerGameMenu' );
			//addNavigationPushButtonEventListenerFromPushButtonId( 'newGameMenuToNewOnlineMultiplayerGameMenu' );
			addNavigationPushButtonEventListenerFromPushButtonId( 'newGameMenuToPreviousMenu' );
		}
	}
}