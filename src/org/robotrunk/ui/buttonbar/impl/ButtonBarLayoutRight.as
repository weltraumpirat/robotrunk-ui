package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	public class ButtonBarLayoutRight extends AbstractButtonBarLayout {
		override protected function positionButton( button:DisplayObject ):void {
			if( button.visible ) {
				_xpos -= button.width;
				button.x = _xpos;
				_xpos -= _offset;
			}
		}

		override protected function validate():Boolean {
			return align is TopButtonBarAlignmentImpl || align is MiddleButtonBarAlignmentImpl || align is BottomButtonBarAlignmentImpl;
		}
	}
}
