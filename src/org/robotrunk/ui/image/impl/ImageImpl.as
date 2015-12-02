package org.robotrunk.ui.image.impl {
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.image.api.Image;

	public class ImageImpl extends UIComponentImpl implements Image {
		override protected function init():void {
			super.init();
			mouseChildren = buttonMode = mouseEnabled = false;
			currentState = "default";
		}
	}
}
