package org.robotrunk.ui.form {
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.button.impl.SwitchButtonImpl;
	import org.robotrunk.ui.form.api.FormElement;

	public class AbstractSelectableFormElementTest {
		protected var button:SwitchButtonImpl;

		[Before(ui, async)]
		public function setUp():void {
			button = getElementInstance();
			(button as FormElement).assignedValue = "someValue";
			var container:UIComponent = new UIComponent();
			container.addChild( button );
			UIImpersonator.addChild( container );
		}

		protected function getElementInstance():SwitchButtonImpl {
			throw new AbstractMethodInvocationException( "You must override the 'getElementInstance()' method." );
		}

		[Test]
		public function switchesStatesOnMouseEvents():void {
			assertEquals( "default", button.currentState );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
			assertEquals( "default", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default_active", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over_active", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default", button.currentState );
		}

		[Test(async)]
		public function dispatchesButtonEventOnMouseClick():void {
			Async.handleEvent( this,
							   button,
							   ButtonEvent.BUTTON_CLICK,
							   function ( ev:Event, passData:Object = null ):void {
								   assertNull( passData );
								   assertEquals( "default_active", button.currentState );
							   } );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}

		[Test]
		public function valueIsReturnedWhenElementIsSelected():void {
			button.active = true;
			assertEquals( "someValue", (button as FormElement).value );
		}

		[Test]
		public function valueIsEmptyWhenElementIsNotSelected():void {
			button.active = false;
			assertEquals( "", (button as FormElement).value );
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			button = null;
		}
	}
}
