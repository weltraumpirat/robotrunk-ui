package org.robotrunk.ui.core.api {
	import flash.utils.Dictionary;

	import org.swiftsuspenders.Injector;

	public interface UIComponentFactory {
		function create( injector:Injector, params:Dictionary ):UIComponent;

		function destroy():void;
	}
}
