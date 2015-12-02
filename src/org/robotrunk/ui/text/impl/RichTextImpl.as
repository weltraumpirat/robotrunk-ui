package org.robotrunk.ui.text.impl {
	import flash.events.Event;

	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.text.api.RichText;

	include "../../../../../../includes/htmlTextImport.as";

	public class RichTextImpl extends UIComponentImpl implements RichText {
		include "../../../../../../includes/htmlText.as";

		override protected function init():void {
			super.init();
			buttonMode = mouseEnabled = false;
			mouseChildren = style.selectable || style.clickable;
			currentState = "default";
		}

		override public function destroy():void {
			states = null;

			super.destroy();
		}

		override protected function onStateRenderComplete( ev:Event ):void {
			super.onStateRenderComplete( ev );
		}
	}
}
