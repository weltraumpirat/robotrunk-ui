package org.robotrunk.ui.text.factory.textfield {
	import flash.text.StyleSheet;

	import org.robotrunk.ui.text.textfield.UITextField;
	import org.robotrunk.ui.text.textfield.classic.MultiLineClassicTextField;
	import org.robotrunk.ui.text.textfield.classic.MultiLineNoWrapClassicTextField;
	import org.robotrunk.ui.text.textfield.classic.SingleLineClassicTextField;

	public class ClassicTextFieldFactory implements TextFieldFactory {
		public function createSingleLineTextField( styleSheet:StyleSheet ):UITextField {
			return new SingleLineClassicTextField( styleSheet );
		}

		public function createMultiLineTextField( styleSheet:StyleSheet ):UITextField {
			return new MultiLineClassicTextField( styleSheet );
		}

		public function createMultiLineNoWrapTextField( styleSheet:StyleSheet ):UITextField {
			return new MultiLineNoWrapClassicTextField( styleSheet );
		}

		public function ClassicTextFieldFactory() {

		}
	}
}
