package org.robotrunk.ui.form.api {

	public interface InputText {
		function get text():String;

		function set text( text:String ):void;

		function get selectionBeginIndex():int;

		function get selectionEndIndex():int;

		function setSelection( startIndex:int, endIndex:int ):void;

		function setFocus():void;
	}
}
