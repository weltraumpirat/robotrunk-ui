package org.robotrunk.ui.core.api {
	import flash.events.IEventDispatcher;

	[Event(name="SCROLL_CHANGE", type="org.robotrunk.ui.core.scroll.event.ScrollEvent")]
	public interface ScrollBehavior extends IEventDispatcher {
		function scroll( max:Number ):void;

		function stopScrolling():void;

		function check( max:Number ):Boolean;

		function destroy():void;
	}
}
