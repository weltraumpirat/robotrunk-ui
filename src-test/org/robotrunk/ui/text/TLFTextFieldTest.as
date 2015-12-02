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

	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.text.StyleSheet;
	import flash.utils.Timer;

	import flashx.textLayout.elements.TextFlow;

	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;

	public class TLFTextFieldTest {
		private var textField:TLFTextField;
		private var styleSheet:StyleSheet;

		[Before]
		public function setUp():void {
			XML.ignoreWhitespace = true;
			XML.prettyPrinting = false;
			textField = new TLFTextField();
			styleSheet = new StyleSheet();
			var css:String = ".text{ font-family:Georgia;font-size:72px;color:#000000;}";
			styleSheet.parseCSS( css );
		}

		[Test(ui, async)]
		public function test():void {

			textField.htmlText = <p class="text">This
				<br />
				is just some test.
				<br/>
				Or is it.</p>;
			textField.wordWrap = false;
			textField.border = true;
			textField.autoSize = "left";
			var myTextFlow:TextFlow = textField.textFlow;
			myTextFlow.formatResolver = new CSSFormatResolver( styleSheet );
			var timer:Timer = new Timer( 120000, 1 );
			Async.proceedOnEvent( this, timer, TimerEvent.TIMER_COMPLETE, 130000 );
			timer.start();

			var disp:DisplayObject = UIImpersonator.testDisplay;
			disp.stage.addChild( textField );
		}

		[After]
		public function tearDown():void {
			textField = null;
		}
	}
}
