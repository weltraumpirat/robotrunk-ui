package org.robotrunk.ui.core.event {
	import flash.events.Event;

	public class ViewEvent extends Event {
		public static const RENDER:String = "RENDER";

		public static const RENDER_COMPLETE:String = "RENDER_COMPLETE";

		public function ViewEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			super( type, bubbles, cancelable );
		}
	}
}
