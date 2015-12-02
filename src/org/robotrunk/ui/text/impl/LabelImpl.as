package org.robotrunk.ui.text.impl {
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.text.api.Label;

	include "../../../../../../includes/htmlTextImport.as";

	public class LabelImpl extends UIComponentImpl implements Label {
		private var _fieldWidth:Number;
		private var _fieldHeight:Number;
		include "../../../../../../includes/htmlText.as";

		override protected function init():void {
			super.init();
			buttonMode = mouseEnabled = false;
			mouseChildren = false;
			currentState = "default";
		}

		override public function destroy():void {
			states = null;

			super.destroy();
		}

		public function get fieldWidth():Number {
			return _fieldWidth;
		}

		public function set fieldWidth( width:Number ):void {
			_fieldWidth = width;
			applyToStyle( "width", width );
			adjustSize();
		}

		private function adjustSize():void {
			for each( var st:UIView in states ) {
				try {
					st.content["adjustSize"]();
				} catch( ignore:Error ) {}
			}
		}

		public function get fieldHeight():Number {
			return _fieldHeight;
		}

		public function set fieldHeight( height:Number ):void {
			_fieldHeight = height;
			applyToStyle( "height", height );
			adjustSize();
		}

		private function applyToStyle( property:String, value:* ):void {
			for each( var stl:Style in allStyles ) {
				stl[property] = value;
			}
		}

		private function get allStyles():Array {
			var styles:Array = [style];
			for each( var st:UIView in states ) {
				styles[styles.length] = st.style;
			}
			return styles;
		}
	}
}
