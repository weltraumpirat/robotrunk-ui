package org.robotrunk.ui.core {
	import flash.display.MovieClip;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotrunk.ui.core.impl.background.ImageBackgroundImpl;

	public class ImageBackgroundTest {
		private var bg:ImageBackgroundImpl;

		[Before]
		public function setUp():void {
			bg = new ImageBackgroundImpl();
		}

		[Test]
		public function addsImageToTheBackgroundAndAppliesStyleParameters():void {
			var img:MovieClip = bg.image = prepareImage();
			var style:Style = prepareStyle();

			bg.draw( style );

			assertTrue( bg.contains( img ) );
			assertEquals( 200, img.width );
			assertEquals( 50, img.height );
			assertEquals( .5, img.alpha );
		}

		private function prepareStyle():Style {
			var style:Style = new Style();
			style.width = 200;
			style.height = 50;
			style.backgroundAlpha = .5;
			return style;
		}

		private function prepareImage():MovieClip {
			var img:MovieClip = new MovieClip();
			with( img.graphics ) {
				beginFill( 0, 1 );
				drawRect( 0, 0, 10, 10 );
				endFill();
			}
			return img;
		}

		[Test]
		public function cleansUpNicely():void {
			var img:MovieClip = bg.image = prepareImage();
			var style:Style = prepareStyle();

			bg.draw( style );

			bg.destroy();

			assertFalse( bg.contains( img ) );
			assertNull( bg.image );
			assertNull( bg.style );
		}

		[After]
		public function tearDown():void {
			bg = null;
		}
	}
}
