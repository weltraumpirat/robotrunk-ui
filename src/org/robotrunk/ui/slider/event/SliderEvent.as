package org.robotrunk.ui.slider.event {
	import flash.events.Event;

	public class SliderEvent extends Event {
		public static const START_SLIDE:String = "START_SLIDE";

		public static const STOP_SLIDE:String = "STOP_SLIDE";

		public static const VALUE_CHANGE:String = "VALUE_CHANGE";

		public var value:*;

		public function SliderEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			super( type, bubbles, cancelable );
		}
	}
}
