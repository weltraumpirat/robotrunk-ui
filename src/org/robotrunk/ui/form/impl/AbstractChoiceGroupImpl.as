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
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;

	import org.robotools.graphics.remove;
	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.core.api.UIComponentFactory;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.form.api.ChoiceGroup;
	import org.robotrunk.ui.form.api.ChoiceItem;

	[Event(name="RENDER", type="org.robotrunk.ui.core.event.ViewEvent")]
	[Event(name="RENDER_COMPLETE", type="org.robotrunk.ui.core.event.ViewEvent")]
	public class AbstractChoiceGroupImpl extends UIComponentImpl implements ChoiceGroup {
		protected var _items:Vector.<ChoiceItem>;

		private var _positions:Array;

		private var _ready:int = 0;

		private var _render:int = 0;

		private var _dataProvider:Array;

		private var _params:CreationParameters;

		private var _itemFactory:UIComponentFactory;

		public function AbstractChoiceGroupImpl() {
			visible = false;
			super();
		}

		override public function destroy():void {
			for each( var btn:ChoiceItem in _items ) {
				destroyButton( btn );
			}

			while( numChildren>0 ) {
				removeChildAt( 0 );
			}

			_items = null;
			super.destroy();
		}

		private function destroyButton( button:ChoiceItem ):void {
			button.removeEventListener( ViewEvent.RENDER_COMPLETE, onButtonRenderComplete );
			button.removeEventListener( ViewEvent.RENDER, onButtonRender );
			button.removeEventListener( ButtonEvent.BUTTON_CLICK, onButtonClick );
			remove( button );
		}

		override protected function init():void {
		}

		public function render():void {
			if( positions ) {
				positionButtons();
			}
			positionComponent();
			visible = true;
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		public function positionButtons():void {
			var i:int = -1;
			while( ++i<positions.length && i<items.length ) {
				try {
					items[i].x = positions[i].x;
					items[i].y = positions[i].y;
				} catch( ignore:Error ) {
				}
			}
		}

		protected function onButtonClick( ev:Event ):void {
			throw new AbstractMethodInvocationException( "You must override the 'onButtonClick' event handler." );
		}

		public function get items():Vector.<ChoiceItem> {
			return _items;
		}

		public function set items( buttons:Vector.<ChoiceItem> ):void {
			_items = buttons;
			_ready = 0;
			_render = 0;
			if( buttons ) {
				for each( var button:ChoiceItem in buttons ) {
					addButton( button );
				}
			}
		}

		private function addButton( button:ChoiceItem ):void {
			button.addEventListener( ViewEvent.RENDER_COMPLETE, onButtonRenderComplete );
			button.addEventListener( ViewEvent.RENDER, onButtonRender );
			button.addEventListener( ButtonEvent.BUTTON_CLICK, onButtonClick );
			addChild( button as DisplayObject );
		}

		private function onButtonRender( ev:ViewEvent ):void {
			if( ev.target == ev.currentTarget ) {
				ev.currentTarget.removeEventListener( ViewEvent.RENDER, onButtonRender );
				if( ++_render>=1 ) {
					dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
				}
			}
		}

		private function onButtonRenderComplete( ev:ViewEvent ):void {
			if( ev.target == ev.currentTarget ) {
				ev.currentTarget.removeEventListener( ViewEvent.RENDER_COMPLETE, onButtonRenderComplete );
				if( ++_ready>=items.length ) {
					render();
				}
			}
		}

		public function get dataProvider():Array {
			return _dataProvider;
		}

		public function set dataProvider( dataProvider:Array ):void {
			_dataProvider = dataProvider;
			if( dataProvider ) {
				items = createItemsFromDataProvider();
			}
		}

		private function createItemsFromDataProvider():Vector.<ChoiceItem> {
			var elms:Vector.<ChoiceItem> = new <ChoiceItem>[];
			var i:int = -1;
			while( ++i<dataProvider.length ) {
				elms[i] = createItem( dataProvider[i], params.asDictionary() );
			}
			return elms;
		}

		private function createItem( entry:Object, dict:Dictionary ):ChoiceItem {
			var element:ChoiceItem = itemFactory.create( params.injector, dict ) as ChoiceItem;
			element.position = null;
			element.assignedValue = entry is String
					? entry as String
					: entry.hasOwnProperty( "value" )
											? entry.value
											: "";
			element.htmlText = entry is String ? entry as String : entry.hasOwnProperty( "text" ) ? entry.text : "";
			return element;
		}

		public function get params():CreationParameters {
			return _params;
		}

		public function set params( value:CreationParameters ):void {
			_params = value;
		}

		public function get itemFactory():UIComponentFactory {
			return _itemFactory;
		}

		public function set itemFactory( value:UIComponentFactory ):void {
			_itemFactory = value;
		}

		public function set positions( positions:Array ):void {
			_positions = positions;
		}

		public function get positions():Array {
			return _positions;
		}

	}
}
