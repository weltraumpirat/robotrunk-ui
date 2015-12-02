package org.robotrunk.ui.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import org.robotools.graphics.drawing.GraphRectangle;

	public class Mask extends Sprite {
		private var _maskee:DisplayObject;

		public function refresh( width:Number, height:Number ):void {
			graphics.clear();
			new GraphRectangle( this ).createRectangle( new Rectangle( 0, 0, width, height ) ).fill( 0,
																									 1 ).noLine().draw();
		}

		public function Mask( maskee:DisplayObject, width:Number, height:Number ) {
			refresh( width, height );
			_maskee = maskee;
			maskee.mask = this;
		}
	}
}
