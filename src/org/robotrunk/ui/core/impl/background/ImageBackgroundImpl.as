package org.robotrunk.ui.core.impl.background {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Background;

	public class ImageBackgroundImpl extends Sprite implements Background {
		private var _style:Style;

		private var _image:MovieClip;

		public function draw( style:Style ):void {
			_style = style;
			renderBackground();
		}

		public function destroy():void {
			graphics.clear();
			if( image && contains( image ) ) {
				removeChild( image );
			}
			_image = null;
			_style = null;
		}

		private function renderBackground():void {
			if( _style.width != null ) {
				_image.width = _style.width;
			}
			if( _style.height != null ) {
				_image.height = _style.height;
			}
			if( _style.backgroundAlpha != null ) {
				_image.alpha = _style.backgroundAlpha;
			}
			addChild( _image );
		}

		public function get image():MovieClip {
			return _image;
		}

		public function set image( image:MovieClip ):void {
			_image = image;
		}

		public function get style():Style {
			return _style;
		}

		public function set style( style:Style ):void {
			_style = style;
		}
	}
}
