package org.robotrunk.ui.slider.api {
	import flash.geom.Rectangle;

	import org.robotrunk.ui.button.api.Button;

	public interface SliderButton extends Button {
		function startDrag( lockCenter:Boolean = false, bounds:Rectangle = null ):void;

		function stopDrag():void;
	}
}
