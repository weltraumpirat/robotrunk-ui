package org.robotrunk.ui.core.util {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.robotrunk.ui.core.InvisibleSprite;

	public class ClickArea extends InvisibleSprite {
		override public function destroy():void {
			removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			removeEventListener( MouseEvent.CLICK, onClick );
			super.destroy();
		}

		private function onClick( ev:Event ):void {
			ev.stopPropagation();
			_target.dispatchEvent( new MouseEvent( MouseEvent.CLICK ) );
		}

		private function onMouseOut( ev:Event ):void {
			ev.stopPropagation();
			_target.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
		}

		private function onMouseOver( ev:Event ):void {
			ev.stopPropagation();
			_target.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
		}

		public function ClickArea( target:DisplayObject ) {
			_target = target;
			buttonMode = true;
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			addEventListener( MouseEvent.CLICK, onClick );
		}
	}
}
