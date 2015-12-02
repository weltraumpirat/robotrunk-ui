package org.robotrunk.ui.core.api {
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;

	import org.robotrunk.ui.core.Style;

	public interface UIView extends GraphicalElement, IEventDispatcher {
		function get autoSizer():AutoSizer;

		function set autoSizer( autoSizer:AutoSizer ):void;

		function get background():Background;

		function set background( background:Background ):void;

		function get content():Sprite;

		function set content( content:Sprite ):void;

		function get shadow():Shadow;

		function set shadow( shadow:Shadow ):void;

		function get style():Style;

		function set style( style:Style ):void;

		function set state( str:String ):void;

		function get state():String;

		function render():void;

		function get rendered():Boolean;
	}
}
