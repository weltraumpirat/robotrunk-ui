package org.robotrunk.ui.text.textfield.classic {
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class BaseTextField extends TextField {

		public function BaseTextField() {
			condenseWhite = embedFonts = true;
			selectable = tabEnabled = false;
			antiAliasType = AntiAliasType.ADVANCED;
			gridFitType = GridFitType.SUBPIXEL;
			autoSize = TextFieldAutoSize.NONE;
			//border = true;
			text = "";
		}
	}
}
