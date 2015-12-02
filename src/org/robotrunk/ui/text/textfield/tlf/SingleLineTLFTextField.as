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

package org.robotrunk.ui.text.textfield.tlf {
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;

	public class SingleLineTLFTextField extends UIComponentTLFTextField {
		private const AUTORESIZE_TEMPWIDTH:int = 1200;

		override public function set htmlText( htmlText:String ):void {
			textField.wordWrap = false;
			if( autoSize && autoSize != TextFieldAutoSize.NONE ) {
				prepareForAutoResize();
			}
			super.htmlText = htmlText;
			textField.wordWrap = false;
		}

		private function prepareForAutoResize():void {
			with( textField ) {
				autoSize = TextFieldAutoSize.NONE;
				width = AUTORESIZE_TEMPWIDTH;
			}
		}

		protected override function processRenderedText():void {
			if( autoSize != TextFieldAutoSize.NONE ) {
				setAutoSize();
			} else if( textField.multiline || textField.wordWrap ) {
				textField.multiline = false;
				textField.wordWrap = false;
				processRenderedText();
			}
			else {
				finishRendering();
			}
		}

		private function setAutoSize():void {
			var wid:Number = 0;
			var hei:Number = 0;
			with( textField ) {
				wid = textWidth+paddingLeft+paddingRight;
				hei = textHeight+paddingTop+paddingBottom;
				if( width != wid || height != hei ) {
					width = wid;
					height = hei;
					super.processRenderedText();
				} else {
					finishRendering();
				}
			}
		}

		public function SingleLineTLFTextField( styleSheet:StyleSheet ) {
			super( styleSheet );
			with( textField ) {
				autoSize = TextFieldAutoSize.NONE;
				multiline = wordWrap = false;
			}
		}
	}
}
