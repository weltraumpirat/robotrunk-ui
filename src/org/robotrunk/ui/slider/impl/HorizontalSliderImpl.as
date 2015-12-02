package org.robotrunk.ui.slider.impl {
	import flash.geom.Rectangle;

	public class HorizontalSliderImpl extends AbstractSliderImpl {
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
			percent = (button.x-padding.getPaddingLeft( style ))/slideWidth*100;
		}

		override protected function positionButton():void {
			if( position ) {
				position.forTarget( button ).within( style ).alignLeft().atMiddle().withPadding().withCoordinates( sliderX,
																												   0 ).apply();
			}
		}

		override protected function positionComponent():void {
		}

		override protected function get dragBounds():Rectangle {
			var left:Number = padding.getPaddingLeft( style );
			var top:Number = padding.getPaddingTop( style );
			return new Rectangle( left, top, slideWidth, slideHeight );
		}

		private function get sliderX():Number {
			return slideWidth*percent*.01;
		}
	}
}
