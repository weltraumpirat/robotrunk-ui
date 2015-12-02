package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	public class ButtonBarLayoutCenter extends AbstractButtonBarLayout {
		private var _totalWidth:Number;

		private function calculateTotalWidth( buttons:Vector.<DisplayObject> ):Number {
			var total:Number = 0;
			buttons.forEach( function ( button:DisplayObject, i:int, self:Vector.<DisplayObject> ):void {
				if( button.visible ) {
					total = (i>0 ? total+button.width+_offset : total+button.width);
				}
				self;
			} );
			return total;
		}

		override protected function positionButton( button:DisplayObject ):void {
			if( button.visible ) {
				button.x = -(_totalWidth*.5)+_xpos;
				_xpos += button.width+_offset;
			}
		}

		override public function position( buttons:Vector.<DisplayObject>, offset:Number = 0 ):void {
			_offset = offset;
			_totalWidth = calculateTotalWidth( buttons );
			super.position( buttons, offset );
		}

		override protected function validate():Boolean {
			return align is TopButtonBarAlignmentImpl || align is MiddleButtonBarAlignmentImpl || align is BottomButtonBarAlignmentImpl;
		}
	}
}
