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

package org.robotrunk.ui.core.util {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.ui.Keyboard;

	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.form.UIComponentInputTLFTextField;

	public class FocusManagerTest {
		private var manager:FocusManager;
		private var testStage:Sprite;

		[Before(ui)]
		public function setUp():void {
			testStage = new Sprite();
			UIImpersonator.testDisplay.stage.addChild( testStage );
			manager = new FocusManager( testStage );
		}

		[Test]
		public function addsInputTextFieldIfTabEnabled():void {
			var tf:UIComponentInputTLFTextField = addATextFieldToTheStage( 1 );
			assertEquals( 0, manager.items.candidates.indexOf( tf ) );
		}

		[Test]
		public function addsDisplayObjectsIfTabEnabled():void {
			var spr:Sprite = addASpriteToTheStage( 1 );
			testStage.addChild( spr );
			assertEquals( 0, manager.items.candidates.indexOf( spr ) );
		}

		[Test]
		public function removesDisplayObjects():void {
			var spr:Sprite = addASpriteToTheStage( 1 );
			testStage.removeChild( spr );
			assertEquals( -1, manager.items.candidates.indexOf( spr ) );
		}

		[Test]
		public function removesInputTextField():void {
			var tf:UIComponentInputTLFTextField = addATextFieldToTheStage( 1 );
			testStage.removeChild( tf as DisplayObject );
			assertEquals( -1, manager.items.candidates.indexOf( tf ) );
		}

		[Test]
		public function itemsAreSortedByTabIndex():void {
			var tf2:UIComponentInputTLFTextField = addATextFieldToTheStage( 2 );
			var tf1:UIComponentInputTLFTextField = addATextFieldToTheStage( 1 );
			var spr2:Sprite = addASpriteToTheStage( 4 );
			var spr1:Sprite = addASpriteToTheStage( 3 );

			assertEquals( 0, manager.items.candidates.indexOf( tf1 ) );
			assertEquals( 1, manager.items.candidates.indexOf( tf2 ) );
			assertEquals( 2, manager.items.candidates.indexOf( spr1 ) );
			assertEquals( 3, manager.items.candidates.indexOf( spr2 ) );
		}

		[Test(async)]
		public function focusIsMovedForwardBetweenObjects():void {
			var tf1:UIComponentInputTLFTextField = addATextFieldToTheStage( 1 );
			var tf2:UIComponentInputTLFTextField = addATextFieldToTheStage( 2 );
			var tf3:UIComponentInputTLFTextField = addATextFieldToTheStage( 3 );

			testStage.stage.focus = tf1.textField;
			var event:FocusEvent = new FocusEvent( FocusEvent.KEY_FOCUS_CHANGE, true );
			event.keyCode = Keyboard.TAB;

			tf1.textField.dispatchEvent( event );
			// focus is automatically placed on a child of TLFTextField!
			assertEquals( tf2.textField, testStage.stage.focus.parent );

			tf2.textField.dispatchEvent( event );
			assertEquals( tf3.textField, testStage.stage.focus.parent );

			tf3.textField.dispatchEvent( event );
			assertEquals( tf1.textField, testStage.stage.focus.parent );
		}

		[Test]
		public function focusIsMovedBackwardBetweenObjects():void {
			var tf1:UIComponentInputTLFTextField = addATextFieldToTheStage( 1 );
			var tf2:UIComponentInputTLFTextField = addATextFieldToTheStage( 2 );
			var tf3:UIComponentInputTLFTextField = addATextFieldToTheStage( 3 );

			testStage.stage.focus = tf1.textField;
			var event:FocusEvent = new FocusEvent( FocusEvent.KEY_FOCUS_CHANGE, true );
			event.keyCode = Keyboard.TAB;
			event.shiftKey = true;

			tf1.textField.dispatchEvent( event );
			assertEquals( tf3.textField, testStage.stage.focus.parent );

			tf3.textField.dispatchEvent( event );
			assertEquals( tf2.textField, testStage.stage.focus.parent );

			tf2.textField.dispatchEvent( event );
			assertEquals( tf1.textField, testStage.stage.focus.parent );

		}

		private function addASpriteToTheStage( tabIndex:int ):Sprite {
			var spr:Sprite = new Sprite();
			spr.tabEnabled = true;
			spr.tabIndex = tabIndex;
			testStage.addChild( spr );
			return spr;
		}

		private function addATextFieldToTheStage( tabIndex:int ):UIComponentInputTLFTextField {
			var tf:UIComponentInputTLFTextField = new UIComponentInputTLFTextField( new Style(), new Padding() );
			tf.tabIndex = tabIndex;
			testStage.addChild( tf as DisplayObject );
			return tf;
		}

		[Test]
		public function cleansUpNicely():void {
			assertEquals( testStage, manager.managedContainer );
			assertThat( manager.items, instanceOf( FocusableItems ) );
			assertTrue( manager.active );
			manager.lastAction = "someAction";

			manager.destroy();

			assertNull( manager.managedContainer );
			assertNull( manager.items );
			assertFalse( manager.active );
			assertNull( manager.lastAction );
		}

		[After(ui)]
		public function tearDown():void {
			manager.destroy();
			manager = null;
		}
	}
}