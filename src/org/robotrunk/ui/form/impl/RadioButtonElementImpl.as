package org.robotrunk.ui.form.impl {
	import org.robotrunk.ui.button.impl.TextSwitchButtonImpl;
	import org.robotrunk.ui.form.api.RadioButtonElement;

	public class RadioButtonElementImpl extends TextSwitchButtonImpl implements RadioButtonElement {
		private var _value:String;

		public function get value():String {
			return active ? _value : "";
		}

		public function set assignedValue( value:String ):void {
			_value = value;
			htmlText = value;
		}

		public function get assignedValue():String {
			return _value;
		}
	}
}
