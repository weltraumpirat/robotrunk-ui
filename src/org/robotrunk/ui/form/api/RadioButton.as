package org.robotrunk.ui.form.api {
	import org.robotrunk.ui.buttonbar.api.ButtonBar;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.form.factory.RadioButtonElementFactory;

	public interface RadioButton extends ButtonBar, FormElement {
		function set dataProvider( dataProvider:Array ):void;

		function get dataProvider():Array;

		function set params( params:CreationParameters ):void;

		function get params():CreationParameters;

		function set elementFactory( factory:RadioButtonElementFactory ):void;

		function get elementFactory():RadioButtonElementFactory;
	}
}
