package org.robotrunk.ui.slider.impl {
	import flash.events.MouseEvent;

	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.button.impl.SimpleButtonImpl;
	import org.robotrunk.ui.slider.api.SliderButton;

	public class SliderButtonImpl extends SimpleButtonImpl implements SliderButton {
		override protected function addListeners():void {
			super.addListeners();
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}

		override protected function removeListeners():void {
			super.removeListeners();
			removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}

		override protected function onMouseUp( ev:MouseEvent ):void {
			ev.stopPropagation();
			if( !stage ) {
				ev.target.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			} else {
				stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				currentState = "default";
				dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_UP ) );
			}
		}

		protected function onMouseDown( ev:MouseEvent ):void {
			ev.stopPropagation();
			currentState = "down";
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0, true );
			dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_DOWN ) );
		}
	}
}
