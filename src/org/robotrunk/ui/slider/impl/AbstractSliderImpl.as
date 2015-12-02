package org.robotrunk.ui.slider.impl {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.slider.api.Slider;
	import org.robotrunk.ui.slider.api.SliderButton;
	import org.robotrunk.ui.slider.event.SliderEvent;

	public class AbstractSliderImpl extends UIComponentImpl implements Slider {
		private var _button:DisplayObject;

		private var _percent:Number = 0;

		private var _value:String;

		[Inject]
		public var padding:Padding;

		public function get button():DisplayObject {
			return _button;
		}

		public function set button( button:DisplayObject ):void {
			_button = button;
			if( button && stage ) {
				initButton();
			}
		}

		override public function destroy():void {
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( Event.ENTER_FRAME, onSlideEnterFrame );

			destroyButton();
			_button = null;
			_percent = 0;
			_value = null;
			padding = null;

			super.destroy();
		}

		private function destroyButton():void {
			removeButtonListeners();
			removeChild( button );
		}

		private function removeButtonListeners():void {
			button.removeEventListener( ButtonEvent.BUTTON_DOWN, onButtonDown );
			button.removeEventListener( ButtonEvent.BUTTON_UP, onButtonUp );
		}

		override protected function init():void {
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			if( button ) {
				initButton();
			}
		}

		private function initButton():void {
			addChild( button );
			addButtonListeners();
			positionButton();
		}

		protected function positionButton():void {
			throw new AbstractMethodInvocationException( "You must implement the 'positionButton()' method." );
		}

		private function addButtonListeners():void {
			button.addEventListener( ButtonEvent.BUTTON_DOWN, onButtonDown );
			button.addEventListener( ButtonEvent.BUTTON_UP, onButtonUp );
		}

		private function onButtonUp( event:ButtonEvent ):void {
			stopSlide();
		}

		protected function stopSlide():void {
			(button as SliderButton).stopDrag();
			removeEventListener( Event.ENTER_FRAME, onSlideEnterFrame );
			pollValue();
			dispatchEvent( new SliderEvent( SliderEvent.STOP_SLIDE ) );
		}

		private function onButtonDown( event:ButtonEvent ):void {
			startSlide();
		}

		protected function startSlide():void {
			(button as SliderButton ).startDrag( false, dragBounds );
			dispatchEvent( new SliderEvent( SliderEvent.START_SLIDE ) );
			addEventListener( Event.ENTER_FRAME, onSlideEnterFrame );
			pollValue();
		}

		private function onSlideEnterFrame( ev:Event ):void {
			pollValue();
		}

		protected function pollValue():void {
			throw new AbstractMethodInvocationException( "You must implement the 'pollValue()' method." );
		}

		public function get percent():Number {
			return _percent;
		}

		public function set percent( percent:Number ):void {
			var changed:Boolean = percent != _percent;
			_percent = percent;
			positionButton();
			if( changed ) {
				dispatchValueChange();
			}
		}

		private function dispatchValueChange():void {
			var event:SliderEvent = new SliderEvent( SliderEvent.VALUE_CHANGE );
			event.value = _percent;
			dispatchEvent( event );
		}

		public function get value():String {
			return _value;
		}

		public function set value( value:String ):void {
			_value = value;
		}

		public function set assignedValue( value:String ):void {
		}

		public function get assignedValue():String {
			return "";
		}

		protected function get dragBounds():Rectangle {
			throw new AbstractMethodInvocationException( "You must implement the 'dragBounds()' getter." );
		}

		protected function get slideWidth():Number {
			var bgWidth:Number = 0;
			for each( var state:UIView in states ) {
				bgWidth = bgWidth>state.background.width ? bgWidth : state.background.width;
			}
			bgWidth = bgWidth>0 ? bgWidth : style.width;
			return style && padding && button ? bgWidth-padding.getPaddingWidth( style )-button.width : width;
		}

		public function set sliderWidth( width:Number ):void {
			for each( var state:UIView in states ) {
				state.background.width = width;
			}
		}

		protected function get slideHeight():Number {
			var bgHeight:Number = 0;
			for each( var state:UIView in states ) {
				bgHeight = bgHeight>state.background.height ? bgHeight : state.background.height;
			}
			bgHeight = bgHeight>0 ? bgHeight : style.height;
			return style && padding && button ? bgHeight-padding.getPaddingHeight( style )-button.height : height;
		}

		public function set sliderHeight( height:Number ):void {
			for each( var state:UIView in states ) {
				state.background.height = height;
			}
		}

	}
}
