package org.robotrunk.ui.slider {
	import flash.events.MouseEvent;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;

	public class SliderButtonTest {
		private var button:SliderButtonImpl;

		[Before(ui)]
		public function setUp():void {
			button = new SliderButtonImpl();

			var container:UIComponent = new UIComponent();
			container.addChild( button );
			UIImpersonator.addChild( container );
		}

		[Test]
		public function changesStatesOnMouseEvent():void {
			assertEquals( "default", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
			assertEquals( "default", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
			assertEquals( "over", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ) );
			assertEquals( "down", button.currentState );

			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( "default", button.currentState );
		}

		[Test(async)]
		public function dispatchesButtonOverEvent():void {
			Async.proceedOnEvent( this, button, ButtonEvent.BUTTON_OVER );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
		}

		[Test(async)]
		public function dispatchesButtonOutEvent():void {
			Async.proceedOnEvent( this, button, ButtonEvent.BUTTON_OUT );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
		}

		[Test(async)]
		public function dispatchesButtonDownEvent():void {
			Async.proceedOnEvent( this, button, ButtonEvent.BUTTON_DOWN );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ) );
		}

		[Test(async)]
		public function dispatchesButtonUpEvents():void {
			Async.proceedOnEvent( this, button, ButtonEvent.BUTTON_UP );
			button.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			button = null;
		}
	}
}
