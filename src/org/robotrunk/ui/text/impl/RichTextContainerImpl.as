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

package org.robotrunk.ui.text.impl {
	import flash.events.Event;

	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.LeftAutoSizerImpl;
	import org.robotrunk.ui.text.api.RichTextContainer;

	public class RichTextContainerImpl extends RichTextImpl implements RichTextContainer {
		public function injectStyle( styleToAdd:Style ):void {
			addStyleProperties( styleToAdd, style );
			for each( var view:UIView in states ) {
				addStyleProperties( styleToAdd, view.style );
				view.autoSizer = view.style.autoSize == "left" ? createAutoSizer() : null;
				view.render();
			}
		}

		private function createAutoSizer():LeftAutoSizerImpl {
			var autoSizer:LeftAutoSizerImpl = new LeftAutoSizerImpl();
			autoSizer.padding = new Padding();
			return autoSizer;
		}

		private function addStyleProperties( styleToAdd:Style, originalStyle:Style ):void {
			for( var prop:String in styleToAdd ) {
				originalStyle[prop] = styleToAdd[prop];
			}
		}

		override protected function onStateRenderComplete( ev:Event ):void {
			super.onStateRenderComplete( ev );
		}
	}
}
