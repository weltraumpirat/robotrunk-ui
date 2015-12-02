package org.robotrunk.ui.buttonbar.api {
	import flash.display.DisplayObject;

	public interface ButtonBarLayout {
		function position( buttons:Vector.<DisplayObject>, offset:Number = 0 ):void;

		function get align():ButtonBarAlignment;

		function set align( align:ButtonBarAlignment ):void;
	}
}
