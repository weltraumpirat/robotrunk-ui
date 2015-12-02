package org.robotrunk.ui.button.impl {
	import flash.events.MouseEvent;

	public dynamic class ToggleButtonImpl extends SwitchButtonImpl {
		override protected function onMouseUp( event:MouseEvent ):void {
			if( event.target == this ) {
				active = !active;
			}
			super.onMouseUp( event );
		}
	}
}
