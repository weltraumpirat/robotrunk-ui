/*
 * Copyright (c) 2012 Tobias Goeschel.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package org.robotrunk.ui.window {
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotrunk.ui.window.impl.ScrollablePane;

	public class ScrollablePaneTest {
		private var pane:ScrollablePane;

		[Before]
		public function setUp():void {
			pane = new ScrollablePane();
		}

		[Test]
		public function holdsContentSprite():void {
			var content:Sprite = new Sprite();
			pane.content = content;
			assertEquals( content, pane.content );
			assertTrue( pane.contains( pane.content ) );
		}

		[Test]
		public function contentIsMaskedWhenPaneIsRendered():void {
			pane.content = new Sprite();
			assertNull( pane.content.mask );
			pane.render();
			assertNotNull( pane.content.mask );
		}

		[Test]
		public function paneSizeIsMaskSizeNotContentSize():void {
			pane.content = new Sprite();
			new GraphRectangle( pane.content ).createRectangle( new Rectangle( 0, 0, 10, 10 ) ).fill( 0, 1 ).draw();
			pane.width = 50;
			pane.height = 50;
			pane.render();
			assertEquals( 10, pane.content.width, pane.content.height );
			assertEquals( 50, pane.width, pane.height );
			assertEquals( 50, pane.content.mask.width, pane.content.mask.height );
		}

		private function setupForScrolling():void {
			pane.content = new Sprite();
			new GraphRectangle( pane.content ).createRectangle( new Rectangle( 0, 0, 100, 100 ) ).fill( 0, 1 ).draw();
			pane.width = 50;
			pane.height = 50;
			pane.render();
		}

		[Test]
		public function maxHorizontalScrollValueMovesContentAllTheWayToTheRight():void {
			setupForScrolling();
			pane.horizontalPosition = 100;
			var bounds:Rectangle = pane.content.getBounds( pane );
			assertEquals( -50, bounds.left );
			assertEquals( 50, bounds.right );
		}

		[Test]
		public function minHorizontalScrollValueMovesContentAllTheWayToTheLeft():void {
			setupForScrolling();
			pane.horizontalPosition = 0;
			var bounds:Rectangle = pane.content.getBounds( pane );
			assertEquals( 0, bounds.left );
			assertEquals( 100, bounds.right );
		}

		[Test]
		public function horizontalValuesInBetweenMixAndMaxAreLinear():void {
			setupForScrolling();
			pane.horizontalPosition = 50;
			var bounds:Rectangle = pane.content.getBounds( pane );
			assertEquals( -25, bounds.left );
			assertEquals( 75, bounds.right );
		}

		[Test]
		public function validHorizontalPositionsAreBetween0And100Percent():void {
			setupForScrolling();
			pane.horizontalPosition = 150;
			assertEquals( 100, pane.horizontalPosition );

			pane.horizontalPosition = -50;
			assertEquals( 0, pane.horizontalPosition );
		}

		[Test]
		public function maxVerticalValueScrollsContentAllTheWayDown():void {
			setupForScrolling();

			pane.verticalPosition = 100;
			var bounds:Rectangle = pane.content.getBounds( pane );
			assertEquals( -50, bounds.top );
			assertEquals( 50, bounds.bottom );
		}

		[Test]
		public function minVerticalValueScrollsContentAllTheWayUp():void {
			setupForScrolling();

			pane.verticalPosition = 0;
			var bounds:Rectangle = pane.content.getBounds( pane );
			assertEquals( 0, bounds.top );
			assertEquals( 100, bounds.bottom );
		}

		[Test]
		public function verticalValuesInBetweenMinAndMaxAreLinear():void {
			setupForScrolling();

			pane.verticalPosition = 50;
			var bounds:Rectangle = pane.content.getBounds( pane );
			assertEquals( -25, bounds.top );
			assertEquals( 75, bounds.bottom );
		}

		[Test]
		public function validVerticalPositionsAreBetween0And100Percent():void {
			setupForScrolling();

			pane.verticalPosition = 150;
			assertEquals( 100, pane.verticalPosition );

			pane.verticalPosition = -50;
			assertEquals( 0, pane.verticalPosition );
		}

		[Test]
		public function cleansUpNicely():void {
			pane.content = new Sprite();
			pane.render();
			assertNotNull( pane.content );
			assertNotNull( pane.contentMask );
			pane.destroy();
			assertNull( pane.content );
			assertNull( pane.contentMask );
		}

		[After]
		public function tearDown():void {
			pane.destroy();
			pane = null;
		}
	}
}