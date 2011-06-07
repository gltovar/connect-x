package view.menuui
{
	import com.bit101.components.Knob;
	import com.bit101.components.NumericStepper;
	
	import flash.events.Event;
	
	import model.GameVO;
	
	public class OptionsMenuUI extends AbstractMenuUI
	{
		
		private var _numericStepperRows:NumericStepper;
		private var _numericStepperColumns:NumericStepper;
		private var _numericStepperConnect:NumericStepper;
		private var _knobMusic:Knob;
		private var _knobSFX:Knob;
		
		public function OptionsMenuUI(p_gameVO:GameVO)
		{
			super(p_gameVO);
			
			getVOValues();
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
							            <HBox spacing="8">
							                <Label text="Columns" />
							                <NumericStepper id="columnCount" width="52" />
							            </HBox>
							            <HBox spacing="20">
							                <Label text="Rows" />
							                <NumericStepper id="rowCount" width="52" />
							            </HBox>
											<HBox spacing="8">				
							                <Label text="Connect" />
							                <NumericStepper id="connectCount" width="52" />
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
			
			_numericStepperColumns = _config.getCompById('columnCount') as NumericStepper;
			_numericStepperRows = _config.getCompById('rowCount') as NumericStepper;
			_numericStepperConnect = _config.getCompById('connectCount') as NumericStepper;
			_knobMusic = _config.getCompById('musicVolume') as Knob;
			_knobSFX = _config.getCompById('sfxVolume') as Knob;
			
			_numericStepperColumns.addEventListener(Event.CHANGE, onDataChange, false, 0, true);
			_numericStepperRows.addEventListener(Event.CHANGE, onDataChange, false, 0, true);
			_numericStepperConnect.addEventListener(Event.CHANGE, onDataChange, false, 0, true);
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;	
		}
		
		private function setVOValues():void
		{
			_gameVO.columns = _numericStepperColumns.value;
			_gameVO.rows = _numericStepperRows.value;
			_gameVO.winningConnectionQuantity = _numericStepperConnect.value;
		}
		
		private function getVOValues():void
		{
			_numericStepperColumns.value = _gameVO.columns;
			_numericStepperRows.value = _gameVO.rows;
			_numericStepperConnect.value = _gameVO.winningConnectionQuantity;
		}
		
		private function onDataChange(e:Event):void
		{
			trace('detecting data change');
			
			setVOValues();
			getVOValues();
		}
	}
}