package org.robotrunk.ui.slider.api {
	import flash.display.DisplayObject;

	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.form.api.FormElement;

	public interface Slider extends FormElement, UIComponent {
		function get percent():Number;

		function set percent( percent:Number ):void;

		function get button():DisplayObject;

		function set button( button:DisplayObject ):void;

		function set sliderWidth( sliderWidth:Number ):void;

		function set sliderHeight( sliderHeight:Number ):void;
	}
}
