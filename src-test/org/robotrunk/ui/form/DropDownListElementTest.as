package org.robotrunk.ui.form {
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.form.impl.DropDownListElementImpl;

	public class DropDownListElementTest {
		private var element:DropDownListElementImpl;

		[Before(ui, async)]
		public function setUp():void {
			element = new DropDownListElementImpl();
			element.assignedValue = "someValue";
			var container:UIComponent = new UIComponent();
			container.addChild( element );
			UIImpersonator.addChild( container );

		}

		[Test]
		public function switchesStatesOnMouseEvents():void {
			assertEquals( "default", element.currentState );
			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", element.currentState );

			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
			assertEquals( "default", element.currentState );

			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", element.currentState );

			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default", element.currentState );

			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", element.currentState );

			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default", element.currentState );
		}

		[Test(async)]
		public function dispatchesButtonEventOnMouseClick():void {
			Async.handleEvent( this,
							   element,
							   ButtonEvent.BUTTON_CLICK,
							   function ( ev:Event, passData:Object = null ):void {
								   assertNull( passData );
								   assertEquals( ButtonEvent.BUTTON_CLICK, ev.type );
							   } );
			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}

		[Test(async)]
		public function doesNotChangeStateToActiveOnMouseClick():void {
			Async.handleEvent( this,
							   element,
							   ButtonEvent.BUTTON_CLICK,
							   function ( ev:Event, passData:Object = null ):void {
								   assertNull( passData );
								   assertEquals( "default", element.currentState );
							   } );
			element.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}

		[Test]
		public function valueIsReturnedWhenDropDownListElementIsSelected():void {
			element.active = true;
			assertEquals( "someValue", element.value );
		}

		[Test]
		public function valueIsEmptyWhenDropDownListElementIsNotSelected():void {
			element.active = false;
			assertEquals( "", element.value );
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			element = null;
		}
	}
}
