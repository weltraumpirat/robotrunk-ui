package org.robotrunk.ui.core.scroll {
	import flash.display.Sprite;

	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.core.scroll.event.ScrollEvent;

	public class AbstractVerticalScrollBehavior extends AbstractScrollBehavior {
		override protected function updateTargetPosition():void {
			var speed:Number = calculateSpeed();
			_target.y = calculateTargetPosition( speed );
			dispatchEvent( new ScrollEvent( ScrollEvent.SCROLL_CHANGE ) );
		}

		public function AbstractVerticalScrollBehavior( target:Sprite, button:Button ) {
			super( target, button );
		}
	}
}
