package org.robotrunk.ui.buttonbar.impl {
	import flash.events.Event;

	public class SwitchButtonBarImpl extends AbstractButtonBarImpl {
		override protected function onButtonClick( ev:Event ):void {
			switchClickedButtonActiveOrInactive( ev.target );
		}

		private function switchClickedButtonActiveOrInactive( clicked:* ):void {
			for each( var button:* in _buttons ) {
				if( button == clicked ) {
					try {
						button.active = !button.active;
					} catch( e:Error ) {
					}
				}
			}
		}

		public function SwitchButtonBarImpl() {
			super();
		}
	}
}
