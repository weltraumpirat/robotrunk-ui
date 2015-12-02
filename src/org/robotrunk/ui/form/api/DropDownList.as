package org.robotrunk.ui.form.api {
	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.button.api.TextButton;
	import org.robotrunk.ui.core.api.UIComponent;

	public interface DropDownList extends UIComponent, CollectionType, FormElement {
		function get items():Array;

		function set items( items:Array ):void;

		function get listButton():TextButton;

		function set listButton( listButton:TextButton ):void;

		function get scrollUpButton():Button;

		function set scrollUpButton( scrollUpButton:Button ):void;

		function get scrollDownButton():Button;

		function set scrollDownButton( scrollUpButton:Button ):void;

		function get dropDownWidth():Number;

		function set dropDownWidth( dropDownWidth:Number ):void;

		function get dropDownHeight():Number;

		function set dropDownHeight( dropDownHeight:Number ):void;

		function get disabled():Boolean;

		function set disabled( value:Boolean ):void;
	}
}
