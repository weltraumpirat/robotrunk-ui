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

package org.robotrunk.ui.text.factory.component {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.robotrunk.ui.text.impl.RichTextContainerImpl;

	public class RichTextContainerFactory extends AbstractRichTextElementFactory {
		public function RichTextContainerFactory( textFieldFactory:TextFieldFactory ) {
			super( textFieldFactory );
		}

		override protected function getTextComponentInstance():UIComponent {
			return parameters.injector.getInstance( RichTextContainerImpl );
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject RichTextContainerImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}

	}
}
