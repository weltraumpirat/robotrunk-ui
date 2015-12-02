package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	public class ButtonBarLayoutUp extends AbstractButtonBarLayout {
		override protected function positionButton( button:DisplayObject ):void {
			if( button.visible ) {
				_ypos -= button.height;
				button.y = _ypos;
				_ypos -= _offset;
			}
		}

		override protected function validate():Boolean {
			return align is LeftButtonBarAlignmentImpl || align is CenterButtonBarAlignmentImpl || align is RightButtonBarAlignmentImpl;
		}
	}
}
