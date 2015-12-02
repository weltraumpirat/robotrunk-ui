package org.robotrunk.ui.form.impl {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class DropDownListImpl extends AbstractDropDownListImpl {

		override protected function showList():void {
			theStage.addEventListener( MouseEvent.CLICK, onStageClick, false, 0, true );
			theStage.addEventListener( Event.RESIZE, onStageResize, false, 0, true );
			list.visible = true;
			listButton.visible = false;
		}

		override protected function initList():void {
			list = new Sprite();
			list.visible = false;
			theStage.addChild( list );
		}
	}
}
