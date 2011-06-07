package view.menuui
{
	import model.GameVO;
	
	public class OptionsMenuUI extends AbstractMenuUI
	{
		public function OptionsMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
		}
		
		override protected function initialize():void
		{
			var xml:XML = 	<comps>
								<Panel id="optionsMenu" x="-60" y="-100" width="120" height="200">
							        <VBox x="10" y="5" spacing="3">
							            <Label x="30" text="Options" />
							            <HBox spacing="20">
							                <Knob id="sfxVolume" label="SFX" />
							                <Knob id="musicVolume" label="Music" />
							            </HBox>
							            <HBox spacing="12">
							                <Label text="Columns" />
							                <NumericStepper id="columnCount" width="48" />
							            </HBox>
							            <HBox spacing="24">
							                <Label text="Rows" />
							                <NumericStepper id="rowCount" width="48" />
							            </HBox>
											<HBox spacing="12">				
							                <Label text="Connect" />
							                <NumericStepper id="connectCount" width="48" />
							            </HBox>
							            <PushButton id="optionsMenuToPreviousMenu" label="Back" />
							        </VBox>
							    </Panel>
							</comps>;
			
			render( xml );
		}
		
		override protected function render(p_xml:XML):void
		{
			super.render(p_xml);
			
			addNavigationPushButtonEventListenerFromPushButtonId( 'optionsMenuToPreviousMenu' );
		}
	}
}