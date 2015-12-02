package org.robotrunk.ui.core.api {
	import org.robotrunk.ui.core.Style;

	public interface Background extends GraphicalElement {
		function draw( style:Style ):void;

		function destroy():void;
	}
}
