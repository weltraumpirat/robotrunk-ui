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
	import org.robotrunk.ui.slider.impl.VerticalSliderImpl;

	public class VerticalSliderTest extends AbstractSliderTest {
		[Before]
		override public function setUp():void {
			slider = new VerticalSliderImpl();
			slider.padding = new Padding();
			sequence = [0, 10, 15, 25, 30, 45, 50, 65, 76, 98, 100];
			style = new Style();
			style.padding = 5;
			style.height = 100;
			style.width = 20;
			slider.style = style;
		}

		[Test(async, ui)]
		public function continuouslyPollsButtonPositionAndChangesValueAccordingly():void {
			slider.style.height = 110;
			slider.percent = 15;
			Async.proceedOnEvent( this, slider, SliderEvent.START_SLIDE );
			mock( button ).asEventDispatcher();
			var c:IMockingGetterCouverture = mock( button ).getter( "y" );
			c.returns.apply( c, [5, 15, 20, 30, 35, 50, 55, 70, 81, 103, 105] );
			slider.addEventListener( SliderEvent.VALUE_CHANGE, onPollChange );
			slider.button = button;
			var container:UIComponent = new UIComponent();
			container.addChild( slider );
			UIImpersonator.addChild( container );
			Async.proceedOnEvent( this, slider, SliderEvent.STOP_SLIDE, 1000 );
			button.dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_DOWN ) );
		}

		private function onPollChange( ev:SliderEvent ):void {
			assertEquals( sequence[++sequenceCount], ev.value );
			if( sequenceCount == sequence.length-1 ) {
				button.dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_UP ) );
			}
		}
	}
}
