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

package org.robotrunk.ui.text {
	import fl.text.TLFTextField;

	import flash.text.Font;
	import flash.text.StyleSheet;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.text.textfield.tlf.SingleLineTLFTextField;

	public class SingleLineTLFTextFieldTest {
		private var container:UIComponent;
		private var textField:SingleLineTLFTextField;
		private var style:StyleSheet;
		private var text:String = "<p><span class=\"something\">Konsequenzen.</span></p>";

		[Before(ui)]
		public function setUp():void {
			Font.registerFont( Arial );
			Font.registerFont( ArialBold );

			container = new UIComponent();
			UIImpersonator.addChild( container );

			style = new StyleSheet();
			style.parseCSS( ".something{font-family:Arial;font-size:11px;color:#000000;font-weight:bold;}" );
			textField = new SingleLineTLFTextField( style );
			textField.autoSize = "left";
		}

		[Test(async, ui)]
		public function performsCorrectAutoSize():void {
			textField.addEventListener( ViewEvent.RENDER_COMPLETE, Async.asyncHandler( this, onRenderComplete, 500 ) );
			textField.htmlText = text;
			container.addChild( textField );
		}

		private function onRenderComplete( ev:ViewEvent, data:* = null ):void {
			var tf:TLFTextField = textField.textField;
			assertEquals( 1, tf.numLines );
			assertFalse( tf.multiline );
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();

			container = null;
			textField = null;
			style = null;
			text = null;
		}
	}
}
