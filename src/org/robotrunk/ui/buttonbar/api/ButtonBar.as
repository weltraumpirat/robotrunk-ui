package org.robotrunk.ui.buttonbar.api {
	import flash.display.DisplayObject;

	import org.robotrunk.ui.core.api.UIComponent;

	public interface ButtonBar extends UIComponent {
		function get buttons():Vector.<DisplayObject>;

		function set buttons( buttons:Vector.<DisplayObject> ):void;

		function get layout():ButtonBarLayout;

		function set layout( layout:ButtonBarLayout ):void;

		function get mode():String;

		function set mode( mode:String ):void;

		function get offset():int;

		function set offset( offset:int ):void;

		function get orientation():String;

		function set orientation( orientation:String ):void;

	}
}
