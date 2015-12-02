package org.robotrunk.ui.slider.impl {
	import flash.geom.Rectangle;

	public class VerticalSliderImpl extends AbstractSliderImpl {
		override protected function init():void {
			super.init();
			currentState = "default";
		}

		override protected function showState( st:String ):void {
			super.showState( st );
			if( button && contains( button ) ) {
				setChildIndex( button, numChildren-1 );
			}
		}

		override protected function pollValue():void {
			percent = (button.y-padding.getPaddingTop( style ))/slideHeight*100;
		}

		override protected function positionButton():void {
			if( position ) {
				position.forTarget( button ).within( style ).center().atTop().withPadding().withCoordinates( 0,
																											 sliderY ).apply();
			}
		}

		override protected function positionComponent():void {
		}

		override protected function get dragBounds():Rectangle {
			var left:Number = padding.getPaddingLeft( style );
			var top:Number = padding.getPaddingTop( style );
			return new Rectangle( left, top, slideWidth, slideHeight );
		}

		private function get sliderY():Number {
			return slideHeight*percent*.01;
		}
	}
}
