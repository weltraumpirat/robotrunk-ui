package org.robotrunk.ui.button.api {
	[Event(name="BUTTON_ACTIVATE", type="org.robotrunk.ui.button.event.ButtonEvent")]
	[Event(name="BUTTON_DEACTIVATE", type="org.robotrunk.ui.button.event.ButtonEvent")]
	public interface SwitchButton extends Button {
		function get active():Boolean;

		function set active( active:Boolean ):void;
	}
}
