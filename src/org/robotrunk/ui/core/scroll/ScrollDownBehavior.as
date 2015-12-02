package org.robotrunk.ui.core.scroll {
	import flash.display.Sprite;

	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.core.api.ScrollBehavior;

	public class ScrollDownBehavior extends AbstractVerticalScrollBehavior implements ScrollBehavior {
		override protected function allowsScrolling():Boolean {
			var minY:Number = -_max;
			return _target.y>minY;
		}

		override protected function calculateSpeed():Number {
			return -buttonClip.mouseY;
		}

		override protected function calculateTargetPosition( speed:Number ):Number {
			var minY:Number = -_max;
			var nextY:Number = _target.y+speed;
			return nextY>minY ? nextY : minY;
		}

		public function ScrollDownBehavior( target:Sprite, button:Button ) {
			super( target, button );
		}
	}
}