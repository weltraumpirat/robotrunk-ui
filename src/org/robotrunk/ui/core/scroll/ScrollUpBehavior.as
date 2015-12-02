package org.robotrunk.ui.core.scroll {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.core.api.ScrollBehavior;

	public class ScrollUpBehavior extends AbstractVerticalScrollBehavior implements ScrollBehavior {
		override protected function allowsScrolling():Boolean {
			return _target.y<0;
		}

		override protected function calculateSpeed():Number {
			var up:DisplayObject = buttonClip;
			return up.height-up.mouseY;
		}

		override protected function calculateTargetPosition( speed:Number ):Number {
			var nextY:Number = _target.y+speed;
			return nextY<0 ? nextY : 0;
		}

		public function ScrollUpBehavior( target:Sprite, button:Button ) {
			super( target, button );
		}
	}
}