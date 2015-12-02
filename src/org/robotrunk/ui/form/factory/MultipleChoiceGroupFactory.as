/*
 * Copyright (c) 2013 Tobias Goeschel.
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

package org.robotrunk.ui.form.factory {
	import org.robotrunk.ui.buttonbar.factory.ButtonBarFactory;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.form.impl.MultipleChoiceGroupImpl;

	public class MultipleChoiceGroupFactory extends ButtonBarFactory {

		override protected function getButtonBarInstance():UIComponent {
			var component:MultipleChoiceGroupImpl = parameters.injector.getInstance( MultipleChoiceGroupImpl );
			component.itemFactory = new ChoiceItemFactory();
			component.params = new CreationParameters( parameters.injector, parameters.asDictionary() );
			component.style = getStyle();
			return component;
		}

		private function getStyle():Style {
			return parameters.styleMap.getComponentStyleCascaded( parameters.type,
																  parameters.clazz,
																  parameters.id );
		}
	}
}
