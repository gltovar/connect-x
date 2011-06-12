package view
{
	import event.ViewEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import interfaces.IView;
	
	import model.ViewLayoutVO;
	
	public class ViewContainer extends Sprite
	{
		private var _layers:Vector.<IView>;
		private var _nativeDimenstions:Point;
		
		public function ViewContainer()
		{
			_layers = new Vector.<IView>;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		public function addLayer(p_layer:IView):void
		{
			p_layer.asDisplayObject().addEventListener( ViewEvent.PERFORM_ACTION, eventForward, false, 0, true);
			
			_layers.push( p_layer );
			addChild( p_layer.asDisplayObject() );
		}
		
		public function RemoveLayer(p_layer:IView):void
		{
			if( _layers.indexOf( p_layer ) != -1 )
			{
				p_layer.asDisplayObject().removeEventListener( ViewEvent.PERFORM_ACTION, eventForward );
				_layers.splice( _layers.indexOf( p_layer ), 1);
				removeChild( p_layer.asDisplayObject() );
			}
			
		}
		
		private function eventForward(e:ViewEvent):void
		{
			e.stopImmediatePropagation();
			
			dispatchEvent( e.clone() );
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_nativeDimenstions = new Point( stage.stageWidth, stage.stageHeight );
			
			stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
		}
		
		private function onStageResize(e:Event):void
		{
			reflowLayout();
		}
		
		public function reflowLayout():void
		{
			trace( 'trying to reflow');
			var orientation:String = (stage.stageWidth >= stage.stageHeight) ? ViewLayoutVO.LAYOUT_ORIENTATION_HORIZONTAL : ViewLayoutVO.LAYOUT_ORIENTATION_VERTICAL;
			
			var viewLayoutPercentageVO:ViewLayoutVO;
			var viewLayoutPixelsVO:ViewLayoutVO;
			var layer:IView;
			for each( layer in _layers )
			{
				for each( viewLayoutPercentageVO in layer.viewLayoutVOs )
				{
					if(viewLayoutPercentageVO.orientation == orientation)
					{	
						viewLayoutPixelsVO = new ViewLayoutVO( viewLayoutPercentageVO.orientation, 
																viewLayoutPercentageVO.x * stage.stageWidth,
																viewLayoutPercentageVO.y * stage.stageHeight,
																viewLayoutPercentageVO.width * stage.stageWidth,
																viewLayoutPercentageVO.height * stage.stageHeight );
						
						layer.reflowView(viewLayoutPixelsVO);
					}
				}
			}
		}
	}
}