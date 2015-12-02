package org.robotrunk.ui.slider {
	import mockolate.ingredients.IMockingGetterCouverture;
	import mockolate.mock;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.slider.event.SliderEvent;
	import org.robotrunk.ui.slider.impl.HorizontalSliderImpl;

	public class HorizontalSliderTest extends AbstractSliderTest {

		[Before]
		override public function setUp():void {
			slider = new HorizontalSliderImpl();
			slider.padding = new Padding();
			sequence = [0, 10, 15, 25, 30, 45, 50, 65, 76, 98, 100];
			style = new Style();
			style.width = 100;
			style.height = 20;
			style.padding = 5;
			style.verticalAlign = "middle";
			slider.style = style;
		}

		[Test(async, ui)]
		public function continuouslyPollsButtonPositionAndChangesValueAccordingly():void {
			slider.style.width = 110;
			mockButton();
			slider.percent = 10;
			Async.proceedOnEvent( this, slider, SliderEvent.START_SLIDE );
			slider.addEventListener( SliderEvent.VALUE_CHANGE, onPollChange );
			slider.button = button;

			var container:UIComponent = new UIComponent();
			container.addChild( slider );
			UIImpersonator.addChild( container );
			Async.proceedOnEvent( this, slider, SliderEvent.STOP_SLIDE, 1000 );
			button.dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_DOWN ) );
		}

		private function mockButton():void {
			mock( button ).asEventDispatcher();
			var c:IMockingGetterCouverture = mock( button ).getter( "x" );
			c.returns.apply( c, [5, 15, 20, 30, 35, 50, 55, 70, 81, 103, 105] );

		}

		private function onPollChange( ev:SliderEvent ):void {
			assertEquals( sequence[++sequenceCount], ev.value );
			if( sequenceCount == sequence.length-1 ) {
				button.dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_UP ) );
			}
		}
	}
}
