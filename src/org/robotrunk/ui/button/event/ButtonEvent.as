package org.robotrunk.ui.button.event {
	import flash.events.Event;

	public class ButtonEvent extends Event {
		public static const BUTTON_CLICK:String = "BUTTON_CLICK";

		public static const BUTTON_ACTIVATE:String = "BUTTON_ACTIVATE";

		public static const BUTTON_DEACTIVATE:String = "BUTTON_DEACTIVATE";

		public static const BUTTON_OUT:String = "BUTTON_OUT";

		public static const BUTTON_OVER:String = "BUTTON_OVER";

		public static const BUTTON_DOWN:String = "BUTTON_DOWN";

		public static const BUTTON_UP:String = "BUTTON_UP";

		public function ButtonEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			super( type, bubbles, cancelable );
		}
	}
}

