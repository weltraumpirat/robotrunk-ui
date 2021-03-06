package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	import org.robotrunk.ui.buttonbar.api.ButtonBarAlignment;

	public class BottomButtonBarAlignmentImpl implements ButtonBarAlignment {
		public function align( buttons:Vector.<DisplayObject> ):void {
			for each( var btn:DisplayObject in buttons ) {
				btn.y = -btn.height;
			}
		}
	}
}
