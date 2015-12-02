package org.robotrunk.ui.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotools.graphics.remove;

	public class InvisibleSprite extends Sprite {
		protected var _target:DisplayObject;

		public function destroy():void {
			remove( this );
			graphics.clear();
			_target = null;
		}

		public function render():void {
			x = _target.x;
			y = _target.y;
			new GraphRectangle( this ).createRectangle( new Rectangle( 0, 0, _target.width,
																	   _target.height ) ).noLine().fill( 0, 0 ).draw();
			if( _target.parent ) {
				_target.parent.addChildAt( this, nextHighestIndex );
			}
		}

		protected function get nextHighestIndex():int {
			return _target.parent.getChildIndex( _target )+1;
		}
	}
}
