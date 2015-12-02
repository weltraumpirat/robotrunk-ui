package org.robotrunk.ui.core.impl.shadow {
	import flash.display.DisplayObject;

	import org.robotools.graphics.drawing.DropShadow;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Shadow;

	public class ComponentDropShadow extends DropShadow implements Shadow {
		public function ComponentDropShadow( target:DisplayObject, style:Style ) {
			super( target );
			atAngle( 90 );
			atDistance( style.shadowDistance || 1 );
			withAlpha( style.shadowAlpha || .5 );
			withBlur( style.shadowBlur || 3 );
			withColor( style.shadowColor || 0 );
		}
	}
}
