package org.robotrunk.ui.core.impl.background {
	import flash.display.Sprite;

	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Background;

	public class EmptyBackgroundImpl extends Sprite implements Background {
		public function draw( style:Style ):void {
		}

		public function destroy():void {
		}
	}
}
