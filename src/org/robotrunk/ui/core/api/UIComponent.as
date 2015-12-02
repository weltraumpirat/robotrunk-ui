package org.robotrunk.ui.core.api {
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;

	public interface UIComponent extends IEventDispatcher, GraphicalElement {
		function destroy():void;

		function get style():Style;

		function set style( style:Style ):void;

		function get currentState():String;

		function set currentState( currentState:String ):void;

		function get states():Dictionary;

		function set states( states:Dictionary ):void;

		function get position():Position;

		function set position( position:Position ):void;

		function get mouseEnabled():Boolean;

		function set mouseEnabled( mouseEnabled:Boolean ):void;

		function applyToStyles( property:String, value:* ):void;
	}
}
