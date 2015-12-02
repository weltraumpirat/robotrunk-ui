package org.robotrunk.ui.text.factory.textfield {
	import flash.text.StyleSheet;

	import org.robotrunk.ui.text.textfield.UITextField;

	public interface TextFieldFactory {
		function createSingleLineTextField( styleSheet:StyleSheet ):UITextField;

		function createMultiLineTextField( styleSheet:StyleSheet ):UITextField;

		function createMultiLineNoWrapTextField( styleSheet:StyleSheet ):UITextField;
	}
}
