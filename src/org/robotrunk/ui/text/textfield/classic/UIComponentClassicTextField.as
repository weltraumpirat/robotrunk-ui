package org.robotrunk.ui.text.textfield.classic {
	import flash.text.StyleSheet;

	public class UIComponentClassicTextField extends SmartClassicTextField {
		private var _styleSheet:StyleSheet;

		override public function set htmlText( text:String ):void {
			super.htmlText = text;
			styleSheet = _styleSheet;
		}

		public function UIComponentClassicTextField( styleSheet:StyleSheet ) {
			super();
			_styleSheet = styleSheet;
		}
	}
}
