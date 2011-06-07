package view.menuui
{
	import com.bit101.components.PushButton;
	import com.bit101.utils.MinimalConfigurator;
	
	import flash.events.MouseEvent;
	
	import model.GameVO;
	
	public class MainMenuUI extends AbstractMenuUI
	{
		public function MainMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
		}
		
		override protected function initialize():void
		{
			var xml:XML = 	<comps>
								<Panel id="mainMenu" x="-60" y="-100" width="120" height="200">
							        <VBox x="10" y="40">
							            <Label x="25" text="Main Menu" />
							            <PushButton id="mainMenuToNewGameMenu" label="New Game" />
							            <PushButton id="mainMenuToLoadGameMenu" label="Continue" />
							            <PushButton id="mainMenuToOptionsMenu" label="Options" />
							        </VBox>
							    </Panel>
							</comps>;
			
			render( xml );
		}
		
		override protected function render(p_xml:XML):void
		{
			super.render(p_xml);
			
			addNavigationPushButtonEventListenerFromPushButtonId( 'mainMenuToNewGameMenu' );
			addNavigationPushButtonEventListenerFromPushButtonId( 'mainMenuToLoadGameMenu' );
			addNavigationPushButtonEventListenerFromPushButtonId( 'mainMenuToOptionsMenu' );
		}
		
		
	}
}