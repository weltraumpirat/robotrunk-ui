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

package org.robotrunk.ui.form.api {
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIComponentFactory;
	import org.robotrunk.ui.core.impl.CreationParameters;

	public interface ChoiceGroup extends UIComponent {
		function get items():Vector.<ChoiceItem>;

		function set items( buttons:Vector.<ChoiceItem> ):void;

		function set dataProvider( dataProvider:Array ):void;

		function get dataProvider():Array;

		function set params( params:CreationParameters ):void;

		function get params():CreationParameters;

		function set itemFactory( factory:UIComponentFactory ):void;

		function get itemFactory():UIComponentFactory;

		function set positions( positions:Array ):void;

		function get positions():Array;

	}
}
