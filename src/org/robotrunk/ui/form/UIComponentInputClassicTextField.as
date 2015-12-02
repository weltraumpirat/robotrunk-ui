package org.robotrunk.ui.form {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;

	public class UIComponentInputClassicTextField extends InputSmartClassicTextField implements UIComponentInputTextField {
		public function UIComponentInputClassicTextField( style:Style, padding:Padding ) {
			autoSize = TextFieldAutoSize.NONE;
			textField.displayAsPassword = style.displayAsPassword != null ? style.displayAsPassword : false;
			adjustSize( style, padding );
			defaultTextFormat = getTextFormatFromStyle( style );
			tabIndex = style.tabIndex ? style.tabIndex : 0;
			tabChildren = tabEnabled = focusEnabled = true;
		}

		private function getTextFormatFromStyle( style:Style ):TextFormat {
			var format:TextFormat = style.toTextFormat();
			format.align = "left";
			this.verticalAlign = "middle";
			this.textAlign = "left";
			return format;
		}

		public function adjustSize( style:Style, padding:Padding ):void {
			width = style.width-padding.getPaddingWidth( style );
			height = style.height-padding.getPaddingHeight( style );
		}
	}
}
