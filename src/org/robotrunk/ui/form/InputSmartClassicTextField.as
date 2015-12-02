package org.robotrunk.ui.form {
	import fl.managers.IFocusManagerComponent;

	import flash.events.FocusEvent;
	import flash.text.TextFieldType;

	import org.robotools.graphics.drawing.VerticalAlign;
	import org.robotrunk.ui.form.event.TextFieldEvent;
	import org.robotrunk.ui.text.textfield.classic.SmartClassicTextField;

	public class InputSmartClassicTextField extends SmartClassicTextField implements IFocusManagerComponent {
		private var _focusEnabled:Boolean = true;
		private var _mouseFocusEnabled:Boolean = true;

		public function InputSmartClassicTextField() {
			super();
			selectable = true;
			type = TextFieldType.INPUT;
			textField.alwaysShowSelection = false;
			textField.addEventListener( FocusEvent.FOCUS_IN, onFocusIn );
			textField.addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
		}

		override protected function applyVerticalAlign():void {
			textField.y = 0;
			textField.y = verticalAlign == VerticalAlign.MIDDLE
					? ( height-textField.height )*.5
					: verticalAlign == VerticalAlign.BOTTOM
								  ? height-textField.height
								  : textField.y;
		}

		private function onFocusOut( ev:FocusEvent ):void {
			dispatchTextFieldEvent( TextFieldEvent.TEXTFIELD_BLUR );
		}

		private function onFocusIn( ev:FocusEvent ):void {
			setSelection( 0, textField.text.length );
			setFocus();
			dispatchTextFieldEvent( TextFieldEvent.TEXTFIELD_FOCUS );
		}

		private function dispatchTextFieldEvent( eventType:String ):void {
			var event:TextFieldEvent = new TextFieldEvent( eventType, true );
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
			stage.focus = textField;
		}

		public function drawFocus( draw:Boolean ):void {
		}
	}
}
