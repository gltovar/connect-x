package view.menuui
{
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
								        <Label x="0" text="New Multiplayer Game" />
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
		}
	}
}