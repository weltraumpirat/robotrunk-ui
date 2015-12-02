package org.robotrunk.ui.text.factory.textfield {
	import flash.text.StyleSheet;

	import org.robotrunk.ui.text.textfield.UITextField;
	import org.robotrunk.ui.text.textfield.tlf.MultiLineNoWrapTLFTextField;
	import org.robotrunk.ui.text.textfield.tlf.MultiLineTLFTextField;
	import org.robotrunk.ui.text.textfield.tlf.SingleLineTLFTextField;

	public class TLFTextFieldFactory implements TextFieldFactory {
		public function createSingleLineTextField( styleSheet:StyleSheet ):UITextField {
			return new SingleLineTLFTextField( styleSheet );
		}

		public function createMultiLineTextField( styleSheet:StyleSheet ):UITextField {
			return new MultiLineTLFTextField( styleSheet );
		}

		public function createMultiLineNoWrapTextField( styleSheet:StyleSheet ):UITextField {
			return new MultiLineNoWrapTLFTextField( styleSheet );
		}
	}
}
