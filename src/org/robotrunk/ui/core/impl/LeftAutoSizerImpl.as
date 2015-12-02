package org.robotrunk.ui.core.impl {
	import flash.text.TextFieldAutoSize;

	import org.robotrunk.common.error.MissingValueException;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.AutoSizer;

	public class LeftAutoSizerImpl implements AutoSizer {
		[Inject]
		public var padding:Padding;

		private var _target:*;

		private var _style:Style;

		public function prepare( target:*, style:Style ):void {
			_style = style;
			_target = target;
		}

		public function get needsAutoSize():Boolean {
			return isAutoSizeEnabled && !targetDimensionsMatchStyleDimensions;
		}

		private function get isAutoSizeEnabled():Boolean {
			return _style.autoSize && _style.autoSize != TextFieldAutoSize.NONE;
		}

		private function get targetDimensionsMatchStyleDimensions():Boolean {
			return targetWidth == _style.width && targetHeight == _style.height;
		}

		private function get targetWidth():Number {
			return padding.getPaddingWidth( _style )+_target.width;
		}

		private function get targetHeight():Number {
			return padding.getPaddingHeight( _style )+_target.height;
		}

		public function resize():void {
			if( isValid() ) {
				_style.width = targetWidth;
				_style.height = targetHeight;
			}
		}

		private function isValid():Boolean {
			if( !padding ) {
				throw new MissingValueException( "You must provide a Padding." );
			}

			if( !_style ) {
				throw new MissingValueException( "No style was set." );
			}

			if( !_target ) {
				throw new MissingValueException( "No target was set." );
			}

			return true;
		}

		public function reset():void {
			_style = null;
			_target = null;
		}
	}
}
