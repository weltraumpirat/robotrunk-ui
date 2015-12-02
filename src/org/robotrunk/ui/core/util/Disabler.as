package org.robotrunk.ui.core.util {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotrunk.ui.core.InvisibleSprite;

	public class Disabler extends InvisibleSprite {

		override public function render():void {
			graphics.clear();
			x = _target.x;
			y = _target.y;
			new GraphRectangle( this ).
					createRectangle( new Rectangle( 0, 0, _target.width, _target.height ) ).
					noLine().fill( 0, .1 ).draw();
			if( _target.parent != null ) {
				_target.parent.addChildAt( this, nextHighestIndex );
			}
		}

		public function Disabler( target:DisplayObject ) {
			_target = target;
			buttonMode = true;
			useHandCursor = false;
		}
	}
}
