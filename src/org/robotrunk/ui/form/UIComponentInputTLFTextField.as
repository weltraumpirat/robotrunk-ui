package org.robotrunk.ui.form {
	import flash.text.TextFieldAutoSize;

	import flashx.textLayout.formats.TextLayoutFormat;

	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;

	public class UIComponentInputTLFTextField extends InputSmartTLFTextField implements UIComponentInputTextField {
		public function UIComponentInputTLFTextField( style:Style, padding:Padding ) {
			autoSize = TextFieldAutoSize.NONE;
			textField.displayAsPassword = style.displayAsPassword != null ? style.displayAsPassword : false;
			adjustSize( style, padding );
			textField.textFlow.hostFormat = getTLFFromStyle( style );
			textField.textFlow.flowComposer.updateAllControllers();
			tabIndex = style.tabIndex ? style.tabIndex : 0;
			tabChildren = true;
			tabEnabled = true;
			focusEnabled = true;
		}

		private function getTLFFromStyle( style:Style ):TextLayoutFormat {
			var format:TextLayoutFormat = style.toTLF();
			format.paddingLeft = format.paddingRight = format.paddingTop = format.paddingBottom = 0;
			format.textAlign = "left";
			format.verticalAlign = "middle";
			format.backgroundAlpha = undefined;
			format.backgroundColor = undefined;
			return format;
		}

		public function adjustSize( style:Style, padding:Padding ):void {
			width = style.width-padding.getPaddingWidth( style );
			height = style.height-padding.getPaddingHeight( style );
		}
	}
}
