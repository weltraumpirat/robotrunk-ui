package org.robotrunk.ui.text.textfield.tlf {
	import flash.text.StyleSheet;

	import org.robotrunk.ui.text.*;

	public class UIComponentTLFTextField extends SmartTLFTextField {
		private var _styleSheet:StyleSheet;

		override protected function createCSSFormatResolver( styleSheet:StyleSheet ):CSSFormatResolver {
			return new UIComponentCSSResolver( styleSheet );
		}

		override public function set htmlText( text:String ):void {
			super.htmlText = text;
			styleSheet = _styleSheet;
		}

		public function UIComponentTLFTextField( styleSheet:StyleSheet ) {
			super();
			_styleSheet = styleSheet;
		}
	}
}
