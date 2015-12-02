package org.robotrunk.ui.buttonbar {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import org.flexunit.asserts.assertEquals;
	import org.robotrunk.ui.buttonbar.api.ButtonBarLayout;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutCenter;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutDown;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutLeft;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutRight;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutUp;
	import org.robotrunk.ui.buttonbar.impl.LeftButtonBarAlignmentImpl;
	import org.robotrunk.ui.buttonbar.impl.TopButtonBarAlignmentImpl;

	public class ButtonBarLayoutTest {
		private var layout:ButtonBarLayout;

		private var buttons:Vector.<DisplayObject>;

		[Before]
		public function setUp():void {
			buttons = new <DisplayObject>[createSprite(), createSprite(), createSprite()];
		}

		private function createSprite():Sprite {
			var spr:Sprite = new Sprite();
			with( spr.graphics ) {
				beginFill( 0, 1 );
				drawRect( 0, 0, 100, 100 );
				endFill();
			}
			return spr;
		}

		[Test]
		public function appliesCorrectLeftLayout():void {
			layout = new ButtonBarLayoutLeft();
			layout.align = new TopButtonBarAlignmentImpl();
			layout.position( buttons, 5 );
			assertEquals( 0, buttons[0].x );
			assertEquals( 0, buttons[0].y );
			assertEquals( 105, buttons[1].x );
			assertEquals( 0, buttons[1].y );
			assertEquals( 210, buttons[2].x );
			assertEquals( 0, buttons[2].y );
		}

		[Test]
		public function appliesCorrectRightLayout():void {
			layout = new ButtonBarLayoutRight();
			layout.align = new TopButtonBarAlignmentImpl();
			layout.position( buttons, 5 );
			assertEquals( -100, buttons[0].x );
			assertEquals( 0, buttons[0].y );
			assertEquals( -205, buttons[1].x );
			assertEquals( 0, buttons[1].y );
			assertEquals( -310, buttons[2].x );
			assertEquals( 0, buttons[2].y );
		}

		[Test]
		public function appliesCorrectDownLayout():void {
			layout = new ButtonBarLayoutDown();
			layout.align = new LeftButtonBarAlignmentImpl();
			layout.position( buttons, 5 );
			assertEquals( 0, buttons[0].x );
			assertEquals( 0, buttons[0].y );
			assertEquals( 0, buttons[1].x );
			assertEquals( 105, buttons[1].y );
			assertEquals( 0, buttons[2].x );
			assertEquals( 210, buttons[2].y );
		}

		[Test]
		public function appliesCorrectUpLayout():void {
			layout = new ButtonBarLayoutUp();
			layout.align = new LeftButtonBarAlignmentImpl();
			layout.position( buttons, 5 );
			assertEquals( 0, buttons[0].x );
			assertEquals( -100, buttons[0].y );
			assertEquals( 0, buttons[1].x );
			assertEquals( -205, buttons[1].y );
			assertEquals( 0, buttons[2].x );
			assertEquals( -310, buttons[2].y );
		}

		[Test]
		public function appliesCorrectCenterLayout():void {
			layout = new ButtonBarLayoutCenter();
			layout.align = new TopButtonBarAlignmentImpl();
			layout.position( buttons, 5 );
			assertEquals( -155, buttons[0].x );
			assertEquals( 0, buttons[0].y );
			assertEquals( -50, buttons[1].x );
			assertEquals( 0, buttons[1].y );
			assertEquals( 55, buttons[2].x );
			assertEquals( 0, buttons[2].y );
		}

		[After]
		public function tearDown():void {
			buttons = null;
			layout = null;
		}
	}
}
