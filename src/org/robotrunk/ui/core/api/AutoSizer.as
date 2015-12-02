package org.robotrunk.ui.core.api {
	import org.robotrunk.ui.core.Style;

	public interface AutoSizer {
		function prepare( target:*, style:Style ):void;

		function get needsAutoSize():Boolean;

		function resize():void;

		function reset():void;
	}
}
