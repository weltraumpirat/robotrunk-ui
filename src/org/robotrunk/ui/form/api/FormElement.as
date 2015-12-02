package org.robotrunk.ui.form.api {

	public interface FormElement {
		function get value():String;

		function set assignedValue( value:String ):void;

		function get assignedValue():String;
	}
}
