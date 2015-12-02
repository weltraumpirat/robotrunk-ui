package org.robotrunk.ui.buttonbar {
	import flash.display.DisplayObject;

	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.robotrunk.ui.button.api.SwitchButton;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.button.impl.SwitchButtonImpl;
	import org.robotrunk.ui.buttonbar.impl.PaletteButtonBarImpl;

	public class PaletteButtonBarTest {
		private var buttons:Vector.<DisplayObject>;

		private var bar:PaletteButtonBarImpl;

		[Before]
		public function setUp():void {
			bar = new PaletteButtonBarImpl();
			buttons = new <DisplayObject>[];
			for( var i:int = 0; i<4; i++ ) {
				createButton( i );
			}
			bar.buttons = buttons;
			SwitchButton( buttons[0] ).active = true;
		}

		private function createButton( i:int ):void {
			var btn:SwitchButton = new SwitchButtonImpl();
			buttons[i] = btn as DisplayObject;
		}

		[Test]
		public function clickingButtonDoesNotAffectState():void {
			buttons[3].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertTrue( SwitchButton( bar.buttons[0] ).active );
			assertFalse( SwitchButton( bar.buttons[1] ).active );
			assertFalse( SwitchButton( bar.buttons[2] ).active );
			assertFalse( SwitchButton( bar.buttons[3] ).active );

			buttons[3].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertTrue( SwitchButton( bar.buttons[0] ).active );
			assertFalse( SwitchButton( bar.buttons[1] ).active );
			assertFalse( SwitchButton( bar.buttons[2] ).active );
			assertFalse( SwitchButton( bar.buttons[3] ).active );
		}
	}
}
