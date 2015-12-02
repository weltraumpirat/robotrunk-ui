package org.robotrunk.ui.form.api {
	import org.robotrunk.ui.core.api.UIComponent;

	public interface InputField extends UIComponent, InputText {
		function set fieldWidth( fieldWidth:Number ):void;

		function get fieldWidth():Number;

		function set fieldHeight( fieldHeight:Number ):void;

		function get fieldHeight():Number;

		function set tabIndex( tabIndex:int ):void;

		function get tabIndex():int;
	}
}
