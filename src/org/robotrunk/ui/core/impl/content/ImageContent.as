package org.robotrunk.ui.core.impl.content {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Content;
	import org.robotrunk.ui.core.event.ViewEvent;

	public class ImageContent extends Sprite implements Content {
		private var _image:DisplayObject;

		private var _style:Style;

		[Inject]
		public var position:Position;

		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			renderImage();
			applyPosition();
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		public function destroy():void {
			while( numChildren>0 ) {
				removeChildAt( 0 );
			}
			position.destroy();
			position = null;
			_style = null;
			_image = null;
		}

		private function renderImage():void {
			addChild( image );
		}

		private function applyPosition():void {
			position.forTarget( this ).within( style ).withPadding().apply();
		}

		public function get image():DisplayObject {
			return _image;
		}

		public function set image( image:DisplayObject ):void {
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
