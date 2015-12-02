package org.robotrunk.ui.core.scroll.event {
	import flash.events.Event;

	public class ScrollEvent extends Event {
		public static const SCROLL_CHANGE:String = "SCROLL_CHANGE";

		public function ScrollEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			super( type, bubbles, cancelable );
		}
	}
}
