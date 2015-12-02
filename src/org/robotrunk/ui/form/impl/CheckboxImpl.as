package org.robotrunk.ui.form.impl {
	import org.robotrunk.ui.button.impl.ToggleButtonImpl;
	import org.robotrunk.ui.form.api.Checkbox;

	public class CheckboxImpl extends ToggleButtonImpl implements Checkbox {
		private var _value:String;

		public function get value():String {
			return active ? _value : "";
		}

		public function get assignedValue():String {
			return _value;
		}

		public function set assignedValue( value:String ):void {
			_value = value;
		}
	}
}
