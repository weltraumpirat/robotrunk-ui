package org.robotrunk.ui.button {
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.button.impl.ToggleButtonImpl;

	public class ToggleButtonTest {
		private var button:ToggleButtonImpl;

		[Before(ui)]
		public function setUp():void {
			button = new ToggleButtonImpl();
			var container:UIComponent = new UIComponent();
			container.addChild( button );
			UIImpersonator.addChild( container );
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
		public function switchesToActiveAndBack():void {
			button.active = true;
			assertEquals( "default_active", button.currentState );
			button.active = false;
			assertEquals( "default", button.currentState );
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			button = null;
		}
	}
}
