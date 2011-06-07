package view.menuui
{
	import model.GameVO;
	
	public class LoadMenuUI extends AbstractMenuUI
	{
		public function LoadMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
		}
		
		override protected function initialize():void
		{
			var xml:XML = 	<comps>
								<Panel id="loadGameMenu" x="-60" y="-100" width="120" height="200">
							        <VBox x="10" y="40">
							            <Label x="25" text="Continue" />
							            <PushButton id="loadFromSharedObject" label="Previous Game" />
							            <PushButton id="loadExternalFile" label="Choose File" />
							            <PushButton id="loadGameMenuToPreviousMenu" label="Back" />
							        </VBox>
							    </Panel>
							</comps>;
			
			render( xml );
		}
		
		override protected function render(p_xml:XML):void
		{
			super.render(p_xml);
			
			//addNavigationPushButtonEventListenerFromPushButtonId( 'loadFromSharedObject' );
			//addNavigationPushButtonEventListenerFromPushButtonId( 'loadExternalFile' );
			addNavigationPushButtonEventListenerFromPushButtonId( 'loadGameMenuToPreviousMenu' );
		}
	}
}