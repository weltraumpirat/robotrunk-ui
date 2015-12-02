package org.robotrunk.ui.core {
	import flash.display.BitmapData;
	import flash.display.Sprite;

	import org.flexunit.asserts.assertEquals;
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;

	public class RectangleBackgroundTest {
		private var bg:RectangleBackgroundImpl;

		[Before]
		public function setUp():void {
			bg = new RectangleBackgroundImpl();
		}

		[Test(ui)]
		public function drawsARectangle():void {
			var compare:Sprite = new Sprite();
			with( compare.graphics ) {
				beginFill( 0, .8 );
				drawRect( 0, 0, 100, 100 );
				endFill();
			}
			var st:Style = new Style();
			st.height = 100;
			st.width = 100;
			st.backgroundColor = 0;
			st.backgroundAlpha = .8;

			bg.draw( st );

			var bmp1:BitmapData = new BitmapData( 100, 100 );
			bmp1.draw( compare );

			var bmp2:BitmapData = new BitmapData( 100, 100 );
			bmp2.draw( bg );
			assertEquals( 0, bmp1.compare( bmp2 ) );
		}

		[After]
		public function tearDown():void {
			bg = null;
		}
	}
}
