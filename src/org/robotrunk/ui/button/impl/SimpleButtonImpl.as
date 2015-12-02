package org.robotrunk.ui.button.impl {
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.core.impl.UIComponentImpl;

	[Event(name="BUTTON_CLICK", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_OVER", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_OUT", type="org.robotrunk.ui.button.event.ButtonEvent")]
	public dynamic class SimpleButtonImpl extends UIComponentImpl implements Button {
		override protected function init():void {
			super.init();
			buttonMode = mouseEnabled = useHandCursor = true;
			mouseChildren = false;
			addListeners();
			currentState = "default";
		}

		override public function destroy():void {
			removeListeners();
			super.destroy();
		}

		protected function addListeners():void {
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		}

		protected function removeListeners():void {
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		}

		protected function onMouseOut( event:MouseEvent ):void {
			event.stopPropagation();
			currentState = "default";
			if( event.target == this ) {
				dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_OUT, true ) );
			}
		}

		protected function onMouseOver( event:MouseEvent ):void {
			event.stopPropagation();
			currentState = "over";
			if( event.target == this ) {
				dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_OVER, true ) );
			}
		}

		protected function onMouseUp( event:MouseEvent ):void {
			event.stopPropagation();
			currentState = "default";
			if( event.target == this ) {
				dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK, true ) );
			}
		}
	}
}
