package org.robotrunk.ui.form {
	import flash.display.DisplayObject;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.form.api.RadioButtonElement;
	import org.robotrunk.ui.form.impl.RadioButtonElementImpl;
	import org.robotrunk.ui.form.impl.RadioButtonImpl;

	public class RadioButtonTest {
		private var buttons:Vector.<DisplayObject>;

		private var radioButton:RadioButtonImpl;

		[Before]
		public function setUp():void {
			radioButton = new RadioButtonImpl();
			buttons = new <DisplayObject>[];
			for( var i:int = 0; i<4; i++ ) {
				createButton( i );
			}
			radioButton.buttons = buttons;
		}

		private function createButton( i:int ):void {
			var btn:RadioButtonElement = new RadioButtonElementImpl();
			btn.assignedValue = i+"";
			buttons[i] = btn as DisplayObject;
		}

		[Test]
		public function firstButtonSelectedByDefault():void {
			assertTrue( RadioButtonElement( radioButton.buttons[0] ).active );
		}

		[Test]
		public function selectedButtonIsActive():void {
			buttons[3].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertTrue( RadioButtonElement( radioButton.buttons[3] ).active );

			buttons[2].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertTrue( RadioButtonElement( radioButton.buttons[2] ).active );
		}

		[Test]
		public function unSelectedButtonsAreInactive():void {
			buttons[3].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertFalse( RadioButtonElement( radioButton.buttons[0] ).active );
			assertFalse( RadioButtonElement( radioButton.buttons[1] ).active );
			assertFalse( RadioButtonElement( radioButton.buttons[2] ).active );

			buttons[2].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertFalse( RadioButtonElement( radioButton.buttons[0] ).active );
			assertFalse( RadioButtonElement( radioButton.buttons[1] ).active );
			assertFalse( RadioButtonElement( radioButton.buttons[3] ).active );
		}

		[Test]
		public function returnsSelectedButtonValue():void {
			assertEquals( "0", radioButton.value );
			buttons[3].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertEquals( "3", radioButton.value );
			buttons[1].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertEquals( "1", radioButton.value );
			buttons[2].dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			assertEquals( "2", radioButton.value );
		}

		[Test]
		public function createsElementsFromDataProvider():void {

		}

		[After]
		public function tearDown():void {
			buttons = null;
			radioButton = null;
		}
	}
}
