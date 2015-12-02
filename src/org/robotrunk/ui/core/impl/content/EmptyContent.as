package org.robotrunk.ui.core.impl.content {
	import flash.display.Sprite;

	import org.robotrunk.ui.core.api.Content;
	import org.robotrunk.ui.core.event.ViewEvent;

	public class EmptyContent extends Sprite implements Content {
		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}
	}
}
