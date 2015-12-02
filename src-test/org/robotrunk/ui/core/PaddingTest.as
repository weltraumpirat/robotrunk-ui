package org.robotrunk.ui.core {
	import org.flexunit.asserts.assertEquals;

	public class PaddingTest {
		private var padding:Padding;
		private var paddingContainer:Object;

		[Before]
		public function setUp():void {
			padding = new Padding();
			paddingContainer = {};
		}

		[Test]
		public function returnsAppropriateValues():void {
			paddingContainer.paddingLeft = 5;
			assertEquals( 5, padding.getPaddingLeft( paddingContainer ) );
			assertEquals( 0, padding.getPaddingRight( paddingContainer ) );
			assertEquals( 0, padding.getPaddingBottom( paddingContainer ) );
			assertEquals( 0, padding.getPaddingTop( paddingContainer ) );
			assertEquals( 5, padding.getPaddingWidth( paddingContainer ) );
			assertEquals( 0, padding.getPaddingHeight( paddingContainer ) );

			paddingContainer.paddingRight = 5;
			assertEquals( 5, padding.getPaddingLeft( paddingContainer ) );
			assertEquals( 5, padding.getPaddingRight( paddingContainer ) );
			assertEquals( 0, padding.getPaddingBottom( paddingContainer ) );
			assertEquals( 0, padding.getPaddingTop( paddingContainer ) );
			assertEquals( 10, padding.getPaddingWidth( paddingContainer ) );
			assertEquals( 0, padding.getPaddingHeight( paddingContainer ) );

			paddingContainer.paddingTop = 5;
			assertEquals( 5, padding.getPaddingLeft( paddingContainer ) );
			assertEquals( 5, padding.getPaddingRight( paddingContainer ) );
			assertEquals( 0, padding.getPaddingBottom( paddingContainer ) );
			assertEquals( 5, padding.getPaddingTop( paddingContainer ) );
			assertEquals( 10, padding.getPaddingWidth( paddingContainer ) );
			assertEquals( 5, padding.getPaddingHeight( paddingContainer ) );

			paddingContainer.paddingBottom = 5;
			assertEquals( 5, padding.getPaddingLeft( paddingContainer ) );
			assertEquals( 5, padding.getPaddingRight( paddingContainer ) );
			assertEquals( 5, padding.getPaddingBottom( paddingContainer ) );
			assertEquals( 5, padding.getPaddingTop( paddingContainer ) );
			assertEquals( 10, padding.getPaddingWidth( paddingContainer ) );
			assertEquals( 10, padding.getPaddingHeight( paddingContainer ) );

			paddingContainer.padding = 10;
			assertEquals( 5, paddingContainer.paddingLeft );
			assertEquals( 5, paddingContainer.paddingRight );
			assertEquals( 5, paddingContainer.paddingTop );
			assertEquals( 5, paddingContainer.paddingBottom );
			assertEquals( 10, padding.getPaddingLeft( paddingContainer ) );
			assertEquals( 10, padding.getPaddingRight( paddingContainer ) );
			assertEquals( 10, padding.getPaddingBottom( paddingContainer ) );
			assertEquals( 10, padding.getPaddingTop( paddingContainer ) );
			assertEquals( 20, padding.getPaddingWidth( paddingContainer ) );
			assertEquals( 20, padding.getPaddingHeight( paddingContainer ) );
		}

		[After]
		public function tearDown():void {
			padding = null;
		}
	}
}
