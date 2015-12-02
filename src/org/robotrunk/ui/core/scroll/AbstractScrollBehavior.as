package org.robotrunk.ui.core.scroll {
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.core.api.ScrollBehavior;

	[Event(name="SCROLL_CHANGE", type="org.robotrunk.ui.core.scroll.event.ScrollEvent")]
	public class AbstractScrollBehavior extends EventDispatcher implements ScrollBehavior {
		protected var _button:Button;

		protected var _target:Sprite;

		protected var _max:Number;

		protected function get buttonClip():DisplayObject {
			return _button as DisplayObject;
		}

		public function set enabled( enabled:Boolean ):void {
			if( enabled ) {
				showButton();
			} else {
				stopScrolling();
				hideButton();
			}
		}

		public function scroll( max:Number ):void {
			_max = max;
			_target.addEventListener( Event.ENTER_FRAME, onScrollEnterFrame );
		}

		public function stopScrolling():void {
			_target.removeEventListener( Event.ENTER_FRAME, onScrollEnterFrame );
		}

		private function showButton():void {
			_button.visible = true;
			TweenMax.to( _button, .5, {alpha: 1, ease: Sine.easeOut} );
		}

		private function hideButton():void {
			TweenMax.to( _button, .5, {
				alpha: 0, ease: Sine.easeIn, onComplete: function ():void {
					if( _button != null ) {
						_button.visible = false;
					}
				}
			} );
		}

		public function destroy():void {
			_button = null;
			_target.removeEventListener( Event.ENTER_FRAME, onScrollEnterFrame );
			_target = null;
			_max = 0;
		}

		protected function onScrollEnterFrame( ev:Event ):void {
			if( mouseInBounds() ) {
				updateTargetPosition();
			} else {
				stopScrolling();
			}
		}

		private function mouseInBounds():Boolean {
			var mouseX:Number = _target.stage.mouseX;
			var mouseY:Number = _target.stage.mouseY;
			return buttonClip.hitTestPoint( mouseX, mouseY );
		}

		protected function updateTargetPosition():void {
			throw new AbstractMethodInvocationException( "You must override the 'updateTargetPosition()' method." );
		}

		protected function calculateSpeed():Number {
			throw new AbstractMethodInvocationException( "You must override the 'calculateSpeed()' method." );
		}

		protected function calculateTargetPosition( speed:Number ):Number {
			throw new AbstractMethodInvocationException( "You must override the 'calculateTargetPosition()' method." );
		}

		public function check( maxHeight:Number ):Boolean {
			_max = maxHeight;
			var allowsScroll:Boolean = allowsScrolling();
			enabled = allowsScroll;
			return allowsScroll;
		}

		protected function allowsScrolling():Boolean {
			throw new AbstractMethodInvocationException( "You must override the 'allowsScrolling()' method." );
		}

		public function AbstractScrollBehavior( target:Sprite, button:Button ) {
			_target = target;
			_button = button;
		}
	}
}