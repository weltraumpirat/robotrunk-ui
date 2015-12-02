package org.robotrunk.ui.core.api {
	import org.robotrunk.ui.core.Style;

	public interface SerialItemFactory {
		function get style():Style;

		function set style( style:Style ):void;

		function create():*;

		function createFrom( dataProvider:* ):Array;
	}
}
