package org.robotrunk.ui.form {
	import fl.managers.IFocusManagerComponent;

	import flash.events.FocusEvent;
	import flash.text.TextFieldType;

	import org.robotrunk.ui.form.event.TextFieldEvent;
	import org.robotrunk.ui.text.textfield.tlf.SmartTLFTextField;

	public class InputSmartTLFTextField extends SmartTLFTextField implements IFocusManagerComponent {
		private var _focusEnabled:Boolean = true;
		private var _mouseFocusEnabled:Boolean = true;

		public function InputSmartTLFTextField() {
			super();
			selectable = true;
			type = TextFieldType.INPUT;
			textField.alwaysShowSelection = false;
			textField.addEventListener( FocusEvent.FOCUS_IN, onFocusIn );
			textField.addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
		}

		private function onFocusOut( ev:FocusEvent ):void {
			dispatchTextFieldEvent( TextFieldEvent.TEXTFIELD_BLUR );
		}

		private function onFocusIn( ev:FocusEvent ):void {
			setSelection( 0, textField.text.length );

			dispatchTextFieldEvent( TextFieldEvent.TEXTFIELD_FOCUS );
		}

		private function dispatchTextFieldEvent( type:String ):void {
			var event:TextFieldEvent = new TextFieldEvent( type, true );
			event.field = textField;
			dispatchEvent( event );
		}

		public function get focusEnabled():Boolean {
			return _focusEnabled;
		}

		public function set focusEnabled( value:Boolean ):void {
			_focusEnabled = value;
		}

		public function get mouseFocusEnabled():Boolean {
			return _mouseFocusEnabled;
		}

		public function set mouseFocusEnabled( enabled:Boolean ):void {
			_mouseFocusEnabled = enabled;
		}

		public function setFocus():void {
			textField.textFlow.interactionManager.setFocus();
		}

		public function drawFocus( draw:Boolean ):void {
		}
	}
}
