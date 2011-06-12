package model
{
	import flash.geom.Rectangle;

	public class ViewLayoutVO
	{
		public static const LAYOUT_ORIENTATION_VERTICAL:String = "orientationVertical";
		public static const LAYOUT_ORIENTATION_HORIZONTAL:String = "orientationHorizontal";
		
		public function ViewLayoutVO(p_orientation:String, p_x:Number, p_y:Number, p_width:Number, p_height:Number)
		{
			_orientation = p_orientation;
			_x = p_x;
			_y = p_y;
			_width = p_width;
			_height = p_height;
		}
		
		private var _y:Number;
		private var _x:Number;
		private var _width:Number;
		private var _height:Number;
		private var _orientation:String;
		
		
		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get orientation():String
		{
			return _orientation;
		}

		public function set orientation(value:String):void
		{
			_orientation = value;
		}

		public function toRectangle():Rectangle
		{
			return new Rectangle( _x, _y, _width, _height );
		}
		
	}
}