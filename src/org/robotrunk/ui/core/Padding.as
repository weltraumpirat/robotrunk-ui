package org.robotrunk.ui.core {
	import org.robotools.data.copy.safeGetPropertyOrDefault;

	public class Padding {
		public function getPaddingWidth( item:* ):Number {
			var padding:Number = safeGetPropertyOrDefault( item, "padding", NaN );
			var paddingLeft:Number = safeGetPropertyOrDefault( item, "paddingLeft", NaN );
			var paddingRight:Number = safeGetPropertyOrDefault( item, "paddingRight", NaN );
			return !isNaN( padding ) ? 2*padding :
				   !isNaN( paddingLeft ) && !isNaN( paddingRight ) ? paddingLeft+paddingRight :
				   !isNaN( paddingLeft ) ? paddingLeft : !isNaN( paddingRight ) ? paddingRight : 0;
		}

		public function getPaddingHeight( item:* ):Number {
			var padding:Number = safeGetPropertyOrDefault( item, "padding", NaN );
			var paddingTop:Number = safeGetPropertyOrDefault( item, "paddingTop", NaN );
			var paddingBottom:Number = safeGetPropertyOrDefault( item, "paddingBottom", NaN );
			return !isNaN( padding ) ? 2*padding :
				   !isNaN( paddingTop ) && !isNaN( paddingBottom ) ? paddingTop+paddingBottom :
				   !isNaN( paddingTop ) ? paddingTop : !isNaN( paddingBottom ) ? paddingBottom : 0;
		}

		public function getPaddingLeft( item:* ):Number {
			var padding:Number = safeGetPropertyOrDefault( item, "padding", NaN );
			var paddingLeft:Number = safeGetPropertyOrDefault( item, "paddingLeft", NaN );
			return !isNaN( padding ) ? padding : !isNaN( paddingLeft ) ? paddingLeft : 0;
		}

		public function getPaddingRight( item:* ):Number {
			var padding:Number = safeGetPropertyOrDefault( item, "padding", NaN );
			var paddingRight:Number = safeGetPropertyOrDefault( item, "paddingRight", NaN );
			return !isNaN( padding ) ? padding : !isNaN( paddingRight ) ? paddingRight : 0;
		}

		public function getPaddingTop( item:* ):Number {
			var padding:Number = safeGetPropertyOrDefault( item, "padding", NaN );
			var paddingTop:Number = safeGetPropertyOrDefault( item, "paddingTop", NaN );
			return !isNaN( padding ) ? padding : !isNaN( paddingTop ) ? paddingTop : 0;
		}

		public function getPaddingBottom( item:* ):Number {
			var padding:Number = safeGetPropertyOrDefault( item, "padding", NaN );
			var paddingBottom:Number = safeGetPropertyOrDefault( item, "paddingBottom", NaN );
			return !isNaN( padding ) ? padding : !isNaN( paddingBottom ) ? paddingBottom : 0;
		}
	}
}
