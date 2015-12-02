package org.robotrunk.ui.buttonbar.impl {
	import flash.events.Event;

	public class RelayButtonBarImpl extends AbstractButtonBarImpl {
		override protected function onButtonClick( ev:Event ):void {
			switchClickedButtonToActiveAndOthersToInactive( ev.target );
		}

		private function switchClickedButtonToActiveAndOthersToInactive( clicked:* ):void {
			for each( var button:* in _buttons ) {
				try {
					button.active = (button == clicked);
				} catch( e:Error ) {
				}
			}
		}

		public function RelayButtonBarImpl() {
			super();
		}
	}
}
