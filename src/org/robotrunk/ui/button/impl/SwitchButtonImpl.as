package org.robotrunk.ui.button.impl {
	import org.robotrunk.ui.button.api.SwitchButton;
	import org.robotrunk.ui.button.event.ButtonEvent;

	[Event(name="BUTTON_CLICK", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_OVER", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_OUT", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_ACTIVATE", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_DEACTIVATE", type="org.robotrunk.ui.button.event.ButtonEvent")]
	public class SwitchButtonImpl extends SimpleButtonImpl implements SwitchButton {
		private var _active:Boolean;

		public function get active():Boolean {
			return _active;
		}

		public function set active( active:Boolean ):void {
			_active = active;
			if( active ) {
				dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_ACTIVATE ) );
			} else {
				dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_DEACTIVATE ) );
			}
		}

		override public function set currentState( state:String ):void {
			super.currentState = active ? state+"_active" : state;
		}

		override protected function removeListeners():void {
			removeEventListener( ButtonEvent.BUTTON_ACTIVATE, onActivate );
			removeEventListener( ButtonEvent.BUTTON_DEACTIVATE, onDeactivate );
			super.removeListeners();
		}

		override protected function addListeners():void {
			addEventListener( ButtonEvent.BUTTON_ACTIVATE, onActivate );
			addEventListener( ButtonEvent.BUTTON_DEACTIVATE, onDeactivate );
			super.addListeners();
		}

		protected function onActivate( ev:ButtonEvent ):void {
			refreshState();
		}

		protected function onDeactivate( ev:ButtonEvent ):void {
			refreshState();
		}

		private function refreshState():void {
			var ind:int = currentState.indexOf( "_" );
			currentState = ind> -1 ? currentState.substr( 0, ind ) : currentState;
		}
	}
}
