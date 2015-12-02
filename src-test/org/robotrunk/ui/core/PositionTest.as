package org.robotrunk.ui.core {
	import flash.display.MovieClip;

	import org.flexunit.asserts.assertEquals;

	public class PositionTest {
		private var clip:MovieClip;

		private var container:MovieClip;

		private var position:Position;

		[Before]
		public function setUp():void {
			position = new Position();
			position.padding = new Padding();
			clip = new MovieClip();
			container = new MovieClip();
		}

		[Test(expects="org.robotrunk.common.error.MissingValueException")]
		public function throwsExceptionIfNoTargetIsSpecified():void {
			position.apply();
		}

		[Test]
		public function positionsClipWithCoordinates():void {
			position.forTarget( clip ).withCoordinates( 10, 5 ).apply();
			assertEquals( 10, clip.x );
			assertEquals( 5, clip.y );
		}

		[Test]
		public function positionsClipWithContainersCssCoordinates():void {
			container.left = 20;
			container.top = 25;
			position.forTarget( clip ).within( container ).usingContainerCoordinates().apply();
			assertEquals( 20, clip.x );
			assertEquals( 25, clip.y );
		}

		[Test]
		public function alignsToTheLeft():void {
			drawItems();

			position.forTarget( clip ).within( container ).alignLeft().apply();
			assertEquals( 0, clip.x );
		}

		[Test]
		public function alignsToTheRight():void {
			drawItems();

			position.forTarget( clip ).within( container ).alignRight().apply();
			assertEquals( 100, clip.x );
		}

		[Test]
		public function xCentersTheClipWithinTheContainer():void {
			drawItems();

			position.forTarget( clip ).within( container ).center().apply();
			assertEquals( 50, clip.x );
		}

		[Test]
		public function alignsAtTheTop():void {
			drawItems();

			position.forTarget( clip ).within( container ).atTop().apply();
			assertEquals( 0, clip.y );
		}

		[Test]
		public function alignsAtTheBottom():void {
			drawItems();

			position.forTarget( clip ).within( container ).atBottom().apply();
			assertEquals( 20, clip.y );
		}

		[Test]
		public function yCentersTheClipWithinTheContainer():void {
			drawItems();

			position.forTarget( clip ).within( container ).atMiddle().apply();
			assertEquals( 10, clip.y );
		}

		[Test]
		public function noAlignmentDefaultsToLeftTop():void {
			drawItems();
			position.forTarget( clip ).within( container ).apply();
			assertEquals( 0, clip.x );
			assertEquals( 10, clip.y );
		}

		[Test]
		public function leftAndTopCoordinatesAddedToAlignment():void {
			drawItems();
			container.left = 10;
			container.top = 10;

			position.forTarget( clip ).within( container ).usingContainerCoordinates().apply();
			assertEquals( 10, clip.x );
			assertEquals( 20, clip.y );

			position.forTarget( clip ).within( container ).alignRight().usingContainerCoordinates().apply();
			assertEquals( 110, clip.x );

			position.forTarget( clip ).within( container ).center().usingContainerCoordinates().apply();
			assertEquals( 60, clip.x );

			position.forTarget( clip ).within( container ).atTop().apply();
			assertEquals( 10, clip.y );

			position.forTarget( clip ).within( container ).atBottom().apply();
			assertEquals( 30, clip.y );

			position.forTarget( clip ).within( container ).atMiddle().apply();
			assertEquals( 20, clip.y );
		}

		[Test]
		public function rightAndBottomCoordinatesSubtractedFromAlignment():void {
			drawItems();
			container.right = 10;
			container.bottom = 10;

			position.forTarget( clip ).within( container ).usingContainerCoordinates().apply();
			assertEquals( -10, clip.x );
			assertEquals( 0, clip.y );

			position.forTarget( clip ).within( container ).alignRight().usingContainerCoordinates().apply();
			assertEquals( 90, clip.x );

			position.forTarget( clip ).within( container ).center().usingContainerCoordinates().apply();
			assertEquals( 40, clip.x );

			position.forTarget( clip ).within( container ).atTop().apply();
			assertEquals( -10, clip.y );

			position.forTarget( clip ).within( container ).atBottom().apply();
			assertEquals( 10, clip.y );

			position.forTarget( clip ).within( container ).atMiddle().apply();
			assertEquals( 0, clip.y );
		}

		[Test]
		public function leftAndTopCoordinatesTakePrecedenceOverRightAndBottomCoordinates():void {
			drawItems();
			container.left = 10;
			container.top = 10;
			container.right = 10;
			container.bottom = 10;

			position.forTarget( clip ).within( container ).usingContainerCoordinates().apply();
			assertEquals( 10, clip.x );
			assertEquals( 20, clip.y );
		}

		[Test]
		public function takesPaddingIntoAccount():void {
			drawItems();

			container.padding = 10;
			position.forTarget( clip ).within( container ).withPadding().apply();
			assertEquals( 10, clip.x );
			assertEquals( 10, clip.y );

			position.forTarget( clip ).alignRight().atBottom().within( container ).withPadding().apply();
			assertEquals( 90, clip.x );
			assertEquals( 10, clip.y );

		}

		private function drawItems():void {
			with( clip.graphics ) {
				beginFill( 0, 1 );
				drawRect( 0, 0, 100, 20 );
				endFill();
			}

			with( container.graphics ) {
				beginFill( 0, 1 );
				drawRect( 0, 0, 200, 40 );
				endFill();
			}
		}

		[After]
		public function tearDown():void {
			position = null;
			clip = null;
			container = null;
		}
	}
}
