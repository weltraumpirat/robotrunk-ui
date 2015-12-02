package org.robotrunk.ui.core {
	import flash.display.Sprite;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.robotrunk.ui.core.impl.LeftAutoSizerImpl;

	public class LeftAutoSizerTest {
		private var autosizer:LeftAutoSizerImpl;

		private var style:Style;

		private var target:Sprite;

		[Before]
		public function setUp():void {
			createTarget();
			createStyle();
			autosizer = new LeftAutoSizerImpl();
			autosizer.padding = new Padding();
			autosizer.prepare( target, style );
		}

		private function createTarget():void {
			target = new Sprite();
			with( target.graphics ) {
				beginFill( 0, 1 );
				drawRect( 0, 0, 100, 50 );
				endFill();
			}
		}

		private function createStyle():void {
			style = new Style();
			style.autoSize = "left";
			style.width = 200;
			style.height = 100;
		}

		[Test]
		public function noAutoSizeNeededIfSizesAreEqual():void {
			style.width = 100;
			style.height = 50;
			target.width = 100;
			target.height = 50;
			assertFalse( autosizer.needsAutoSize );
		}

		[Test]
		public function autoSizeNeededIfHeightIsNotEqual():void {
			style.width = 100;
			style.height = 75;
			target.width = 100;
			target.height = 50;
			assertTrue( autosizer.needsAutoSize );
		}

		[Test]
		public function autoSizeNeededIfWidthIsNotEqual():void {
			style.width = 150;
			style.height = 50;
			target.width = 100;
			target.height = 50;
			assertTrue( autosizer.needsAutoSize );
		}

		[Test]
		public function resizesTargetToStyleSize():void {
			autosizer.resize();
			assertEquals( style.width, target.width );
			assertEquals( style.height, target.height );
		}

		[Test(expects="org.robotrunk.common.error.MissingValueException")]
		public function throwsErrorIfResizeIsCalledAfterCleanUp():void {
			autosizer.reset();
			autosizer.resize();
		}

		[Test(expects="org.robotrunk.common.error.MissingValueException")]
		public function throwsErrorIfResizeIsCalledWithoutPadding():void {
			autosizer.padding = null;
			autosizer.resize();
		}

		[After]
		public function tearDown():void {
			style = null;
			target = null;
			autosizer = null;
		}
	}
}
