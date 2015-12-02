package org.robotrunk.ui.slider {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.slider.event.SliderEvent;
	import org.robotrunk.ui.slider.impl.AbstractSliderImpl;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;

	public class AbstractSliderTest {
		public var slider:AbstractSliderImpl;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var button:SliderButtonImpl;

		public var style:Style;

		public var sequence:Array;

		public var sequenceCount:int = -1;

		[Before]
		public function setUp():void {
			throw new AbstractMethodInvocationException( "You must override the 'setUp()' method." );
		}

		[Test(async, ui)]
		public function startsDragOnMouseDown():void {
			mock( button ).asEventDispatcher();
			mock( button ).method( "startDrag" ).args( false, instanceOf( Rectangle ) );
			slider.button = button as DisplayObject;
			var container:UIComponent = new UIComponent();
			container.addChild( slider );
			UIImpersonator.addChild( container );
			Async.proceedOnEvent( this, slider, SliderEvent.START_SLIDE );
			button.dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_DOWN ) );
		}

		[Test(async, ui)]
		public function stopsDragOnMouseUp():void {
			mock( button ).asEventDispatcher();
			mock( button ).method( "stopDrag" );
			slider.button = button as DisplayObject;
			var container:UIComponent = new UIComponent();
			container.addChild( slider );
			UIImpersonator.addChild( container );
			Async.proceedOnEvent( this, slider, SliderEvent.STOP_SLIDE );
			button.dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_UP ) );
		}

		[Test(async, ui)]
		public function dispatchesEventsWhenValueChanges():void {
			mock( button );
			slider.button = button;
			slider.addEventListener( SliderEvent.VALUE_CHANGE, onValueChange );
			var container:UIComponent = new UIComponent();
			container.addChild( slider );
			UIImpersonator.addChild( container );
			Async.proceedOnEvent( this, slider, SliderEvent.VALUE_CHANGE );
			while( ++sequenceCount<sequence.length ) {
				slider.percent = sequence[sequenceCount];
			}
		}

		protected function mockPosition():void {
			throw new AbstractMethodInvocationException( "You must override the 'mockPosition()' method." );
		}

		private function onValueChange( ev:SliderEvent ):void {
			assertEquals( sequence[sequenceCount], ev.value );
		}

		[Test(async)]
		public function doesNotDispatchEventIfValueStaysEqual():void {
			slider.percent = 10;
			Async.failOnEvent( this, slider, SliderEvent.VALUE_CHANGE );
			for( var i:int = 0; i<10; i++ ) {
				slider.percent = 10;
			}
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			slider = null;
			button = null;
			rule = null;
			style = null;
			sequence = null;
			sequenceCount = -1;
		}
	}
}
