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

package org.robotrunk.ui.form.impl {
	import flash.events.Event;

	import org.robotools.text.stripMarkup;
	import org.robotrunk.ui.form.api.ChoiceItem;
	import org.robotrunk.ui.form.api.MultipleChoiceGroup;

	public class MultipleChoiceGroupImpl extends AbstractChoiceGroupImpl implements MultipleChoiceGroup {
		private var _values:Array = [];

		public function get values():Array {
			return selectedButtonValues;
		}

		public function set values( values:Array ):void {
			_values = values;
			selectButtonsAccordingToValue();
		}

		private function get selectedButtonValues():Array {
			var selected:Array = [];
			for each( var btn:ChoiceItem in items ) {
				if( btn.active ) {
					selected[selected.length] = stripMarkup( btn.value );
				}
			}
			return selected;
		}

		private function selectButtonsAccordingToValue():void {
			for each( var btn:ChoiceItem in items ) {
				for each( var val:String in _values ) {
					btn.active = btn.assignedValue == val;
				}
			}
		}

		override public function set items( items:Vector.<ChoiceItem> ):void {
			super.items = items;
		}

		override protected function onButtonClick( ev:Event ):void {
			switchClickedButtonActiveOrInactive( ev.target );
		}

		private function switchClickedButtonActiveOrInactive( clicked:* ):void {
			for each( var item:* in items ) {
				if( item == clicked ) {
					try {
						item.active = !item.active;
					} catch( e:Error ) {
					}
				}
			}
		}
	}
}
