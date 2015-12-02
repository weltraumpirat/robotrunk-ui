package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	public class ButtonBarLayoutLeft extends AbstractButtonBarLayout {
		override protected function positionButton( button:DisplayObject ):void {
			if( button.visible ) {
				button.x = _xpos;
				_xpos += button.width+_offset;
			}
		}

		override protected function validate():Boolean {
			return align is TopButtonBarAlignmentImpl || align is MiddleButtonBarAlignmentImpl || align is BottomButtonBarAlignmentImpl;
		}
	}
}
