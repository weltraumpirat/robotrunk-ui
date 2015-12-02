package org.robotrunk.ui.form {
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.button.impl.SwitchButtonImpl;
	import org.robotrunk.ui.form.impl.RadioButtonElementImpl;

	public class RadioButtonElementTest extends AbstractSelectableFormElementTest {
		override protected function getElementInstance():SwitchButtonImpl {
			return new RadioButtonElementImpl();
		}

		[Test]
		override public function switchesStatesOnMouseEvents():void {
			assertEquals( "default", button.currentState );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
			assertEquals( "default", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default", button.currentState );
		}

		[Test(async)]
		override public function dispatchesButtonEventOnMouseClick():void {
			Async.handleEvent( this,
							   button,
							   ButtonEvent.BUTTON_CLICK,
							   function ( ev:Event, passData:Object = null ):void {
								   assertNull( passData );
								   assertEquals( "default", button.currentState );
							   } );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}

	}
}
