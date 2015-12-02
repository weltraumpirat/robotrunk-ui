package org.robotrunk.ui.form.api {
	import org.robotrunk.ui.button.api.SwitchButton;
	import org.robotrunk.ui.button.api.TextButton;

	public interface DropDownListElement extends TextButton, SwitchButton, FormElement {

		function set elementWidth( wid:Number ):void;
	}
}
