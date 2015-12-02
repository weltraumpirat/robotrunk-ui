package org.robotrunk.ui.form.impl {
	import org.robotrunk.ui.button.impl.TextSwitchButtonImpl;
	import org.robotrunk.ui.form.api.DropDownListElement;

	public class DropDownListElementImpl extends TextSwitchButtonImpl implements DropDownListElement {
		private var _value:String;

		public function DropDownListElementImpl( value:String = null ) {
			_value = value;
		}

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

		public function set elementWidth( wid:Number ):void {
			applyToStyles( "width", wid );
		}
	}
}
