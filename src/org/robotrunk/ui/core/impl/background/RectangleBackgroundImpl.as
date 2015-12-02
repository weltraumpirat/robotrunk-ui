package org.robotrunk.ui.core.impl.background {
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Background;

	public class RectangleBackgroundImpl extends Sprite implements Background {
		private var _style:Style;
		private var _corner:Number;
		private var _backgroundColor:int;
		private var _backgroundAlpha:Number;
		private var _frameSize:Number;
		private var _frameColor:uint;
		private var _frameAlpha:uint;
		private var _width:Number;
		private var _height:Number;

		public function draw( style:Style ):void {
			_style = style;
			parseStyleParameters();
			renderBackground();
		}

		public function destroy():void {
			graphics.clear();
			_style = null;
			_corner = 0;
			_backgroundAlpha = 0;
			_frameAlpha = 0;
			_backgroundColor = 0;
			_frameColor = 0;
			_frameSize = 0;
			_width = 0;
			_height = 0;
		}

		private function parseStyleParameters():void {
			_width = _style.width != null ? _style.width : 0;
			_height = _style.height != null ? _style.height : 0;
			_corner = _style.cornerRadius != null ? _style.cornerRadius : 0;
			_backgroundColor = _style.backgroundColor != null ? _style.backgroundColor : -1;
			_backgroundAlpha = _style.backgroundAlpha != null ? _style.backgroundAlpha : 1;
			_frameSize = _style.frameSize != null ? _style.frameSize : -1;
			_frameColor = _style.frameColor != null ? _style.frameColor : 0;
			_frameAlpha = _style.frameAlpha != null ? _style.frameAlpha : 1;
		}

		private function renderBackground():void {
			graphics.clear();
			var box:Rectangle = new Rectangle( 0, 0, _width, _height );
			var rect:GraphRectangle = new GraphRectangle( this );
			rect = rect.createRectangle( box );
			rect = hasFill ? rect.fill( _backgroundColor, _backgroundAlpha ) : rect;
			rect = hasFrame ? rect.line( _frameSize, _frameColor, _frameAlpha ) : rect;
			rect = hasRoundCorners ? rect.withRoundCorners( _corner ) : rect;
			rect.draw();
		}

		private function get hasRoundCorners():Boolean {
			return _corner>0;
		}

		private function get hasFrame():Boolean {
			return _frameSize>0;
		}

		private function get hasFill():Boolean {
			return _backgroundColor> -1;
		}
	}
}
