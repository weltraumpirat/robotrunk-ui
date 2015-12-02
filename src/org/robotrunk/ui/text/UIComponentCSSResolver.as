package org.robotrunk.ui.text {
	import flash.text.StyleSheet;

	import flashx.textLayout.formats.TextLayoutFormat;

	import org.robotools.data.propertyCount;
	import org.robotrunk.ui.core.Style;

	public class UIComponentCSSResolver extends CSSFormatResolver {
		override protected function applyToTextLayoutFormat( style:Style ):TextLayoutFormat {
			return (style && propertyCount( style )>0) ? removePaddingAndBackground( style.toTLF() ) : undefined;
		}

		private function removePaddingAndBackground( tlf:TextLayoutFormat ):TextLayoutFormat {
			tlf.paddingTop = tlf.paddingBottom = tlf.paddingLeft = tlf.paddingRight = 0;
			tlf.backgroundAlpha = undefined;
			tlf.backgroundColor = undefined;
			//tlf.textAlign = undefined;
			//tlf.verticalAlign = undefined;
			return tlf;
		}

		public function UIComponentCSSResolver( styleSheet:StyleSheet ) {
			super( styleSheet );
		}
	}
}
