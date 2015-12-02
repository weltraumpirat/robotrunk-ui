package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	public class ButtonBarLayoutDown extends AbstractButtonBarLayout {
		override protected function positionButton( button:DisplayObject ):void {
			if( button.visible ) {
				button.y = _ypos;
				_ypos += button.height+_offset;
			}
		}

		override protected function validate():Boolean {
			return align is LeftButtonBarAlignmentImpl || align is CenterButtonBarAlignmentImpl || align is RightButtonBarAlignmentImpl;
		}
	}
}
