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
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import org.robotools.graphics.bringToFront;
	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotools.graphics.globalPosition;
	import org.robotools.graphics.remove;
	import org.robotools.graphics.removeAll;
	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.button.api.TextButton;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.core.impl.content.TextImageContent;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;
	import org.robotrunk.ui.form.api.DropDownList;
	import org.robotrunk.ui.form.api.DropDownListElement;
	import org.robotrunk.ui.form.event.FormItemEvent;
	import org.robotrunk.ui.form.factory.DropDownListElementFactory;

	public class AbstractDropDownListImpl extends UIComponentImpl implements DropDownList {
		private const STAGE_OFFSET:int = 15;
		private const ACCELERATION:Number = 1;
		private var _listButton:TextButton;
		private var _scrollUpButton:Button;
		private var _scrollDownButton:Button;
		private var _items:Array;
		private var _value:String;
		private var _list:Sprite;
		private var _dataProvider:Array;
		private var _elementFactory:DropDownListElementFactory;
		private var _params:CreationParameters;
		private var _shadow:ComponentDropShadow;
		private var _dropDownHeight:Number;
		private var _dropDownWidth:Number;
		private var _mask:Sprite;
		private var _disabled:Boolean;

		[Inject]
		public var theStage:Stage;
		private var _scroll:Number;

		public function AbstractDropDownListImpl():void {
			super();
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}

		public function get dataProvider():Array {
			return _dataProvider;
		}

		public function set dataProvider( dataProvider:Array ):void {
			_dataProvider = dataProvider;
			items = createListItemsFromDataProvider();
		}

		private function createListItemsFromDataProvider():Array {
			var dict:Dictionary = params.asDictionary();
			var elms:Array = [];
			for each( var entry:String in dataProvider ) {
				elms.push( createElement( entry, dict ) );
			}
			return elms;
		}

		private function createElement( entry:String, dict:Dictionary ):DropDownListElement {
			var element:DropDownListElement = elementFactory.create( params.injector, dict )
											  as DropDownListElement;
			element.position = null;
			element.assignedValue = entry;
			return element;
		}

		public function get selectedItem():* {
			for each( var item:DropDownListElement in items ) {
				if( item.active ) {
					return item;
				}
			}
			return null;
		}

		public function get value():String {
			var s:DropDownListElement = selectedItem;
			return s ? s.value : _value;
		}

		public function get listButton():TextButton {
			return _listButton;
		}

		public function set listButton( listButton:TextButton ):void {
			_listButton = listButton;
			if( listButton ) {
				addChild( listButton as DisplayObject );
				listButton.addEventListener( ButtonEvent.BUTTON_CLICK, onListButtonClick );
			}
		}

		private function onListButtonClick( event:ButtonEvent ):void {
			updateList();
			showList();
			bringToFront( _scrollUpButton as DisplayObject );
			bringToFront( _scrollDownButton as DisplayObject );
		}

		protected function showList():void {
			throw new AbstractMethodInvocationException( "You must override the 'showList()' method." );
		}

		protected function onStageClick( event:MouseEvent ):void {
			var pos:Point = new Point( event.stageX, event.stageY );
			if( stage && clickedOutsideOfList( pos ) ) {
				showButton();
			} else if( stage == null ) {
				event.currentTarget.removeEventListener( MouseEvent.CLICK, onStageClick );
			}
		}

		protected function onStageResize( event:Event ):void {
			if( stage ) {
				showButton();
			} else {
				event.currentTarget.$removeEventListener( Event.RESIZE, onStageResize );
			}
		}

		private function clickedOutsideOfList( pos:Point ):Boolean {
			return !(list.hitTestPoint( pos.x, pos.y ) || (listButton as DisplayObject).hitTestPoint( pos.x, pos.y ));
		}

		private function updateList():void {
			createShadowIfApplicable();
			resetListPosition();
			initListItemPositions();
			list.y = listYPosition;
			updateScrollers();
		}

		private function updateScrollers():void {
			initButton( _scrollDownButton, theStage.stageHeight-STAGE_OFFSET-style.height,
						listWillExtendBeyondLowerStageBorder );
			initButton( _scrollUpButton, STAGE_OFFSET, listWillExtendBeyondUpperStageBorder );
			list.mask = needsMask ? drawMask() : null;
		}

		private function initButton( button:Button, position:int, active:Boolean ):void {
			if( !theStage.contains( button as DisplayObject ) ) {
				initScrollButton( button );
			}

			button.x = list.x;
			button.y = position;

			if( active ) {
				enableScrollButton( button );
			} else {
				disableScrollButton( button );
			}
		}

		private function initScrollButton( button:Button ):void {
			button.position = null;
			setButtonSize( button );
			theStage.addChild( button as DisplayObject );
		}

		private function enableScrollButton( button:Button ):void {
			button.visible = true;
			button.addEventListener( ButtonEvent.BUTTON_OVER, onScrollStart );
			button.addEventListener( ButtonEvent.BUTTON_OUT, onScrollEnd );
		}

		private function disableScrollButton( button:Button ):void {
			button.visible = false;
			button.removeEventListener( ButtonEvent.BUTTON_OVER, onScrollStart );
			button.removeEventListener( ButtonEvent.BUTTON_OUT, onScrollEnd );
		}

		private function onScrollStart( event:ButtonEvent ):void {
			_scroll = event.target == _scrollUpButton ? 1 : -1;
			addEventListener( Event.ENTER_FRAME, onScrollEnterFrame );
		}

		private function onScrollEnd( event:ButtonEvent ):void {
			_scroll = 0;
			removeEventListener( Event.ENTER_FRAME, onScrollEnterFrame );
		}

		private function onScrollEnterFrame( event:Event ):void {
			if( list == null || list.stage == null ) {
				removeEventListener( Event.ENTER_FRAME, onScrollEnterFrame );
			} else {
				_scroll += _scroll<0 ? -1*ACCELERATION : ACCELERATION;
				if( (_scroll>0 && list.y<STAGE_OFFSET) || (_scroll<0 && list.y+list.height>theStage.stageHeight-STAGE_OFFSET) ) {
					list.y += _scroll;
					updateScrollers();
				} else {
					onScrollEnd( null );
				}
			}
		}

		private function setButtonSize( component:UIComponent ):void {
			component.applyToStyles( "width", list.width );
			component.applyToStyles( "height", style.height );
		}

		private function drawMask():Sprite {
			_mask ||= new Sprite();
			_mask.graphics.clear();
			var upper:Number = _scrollUpButton.visible
					? (_scrollUpButton as DisplayObject).getBounds( theStage ).bottom : STAGE_OFFSET;
			var lower:Number = _scrollDownButton.visible
					? (_scrollDownButton as DisplayObject ).getBounds( theStage ).top
					: theStage.stageHeight-STAGE_OFFSET;
			var bounds:Rectangle = new Rectangle( list.x, upper, list.x+list.width, lower-upper );
			new GraphRectangle( _mask ).createRectangle( bounds ).fill( 0, 1 ).draw();
			return _mask;
		}

		private function get needsMask():Boolean {
			return _scrollDownButton.visible || _scrollUpButton.visible;
		}

		private function createShadowIfApplicable():void {
			if( style.shadow ) {
				_shadow ||= new ComponentDropShadow( list, style );
				_shadow.create();
			}
		}

		private function resetListPosition():void {
			var pos:Point = globalPosition( listButton );
			list.x = pos.x;
			list.y = pos.y;
		}

		private function initListItemPositions():void {
			var position:int = 0;
			for each( var item:DropDownListElement in items ) {
				item.visible = true;
				item.alpha = 1;
				item.y = position;
				position += item.style.height;
			}
		}

		private function get listYPosition():Number {
			return list.y-selectedItemPosition;
		}

		private function get selectedItemPosition():Number {
			for each( var item:DropDownListElement in items ) {
				if( item.active ) {
					return item.y;
				}
			}
			return 0;
		}

		private function get listWillExtendBeyondUpperStageBorder():Boolean {
			return list.y<0;
		}

		private function get listWillExtendBeyondLowerStageBorder():Boolean {
			return list.y+list.height>theStage.stageHeight;
		}

		private function onButtonActivate( event:ButtonEvent ):void {
			deactivateOtherElements( event.target as DropDownListElement );
			showUpdatedListButton( event.target as DropDownListElement );
			dispatchChangeEvent();
		}

		private function deactivateOtherElements( activeElement:DropDownListElement ):void {
			for each( var item:DropDownListElement in items ) {
				if( item != activeElement ) {
					item.active = false;
				}
			}
		}

		private function showUpdatedListButton( activeElement:DropDownListElement ):void {
			listButton.htmlText = activeElement.htmlText;
			showButton();
		}

		private function showButton():void {
			theStage.removeEventListener( MouseEvent.CLICK, onStageClick );
			theStage.removeEventListener( Event.RESIZE, onStageResize );
			list.visible = false;
			onScrollEnd( null );
			_scrollDownButton.visible = false;
			_scrollUpButton.visible = false;
			listButton.visible = true;
		}

		private function dispatchChangeEvent():void {
			dispatchEvent( new FormItemEvent( FormItemEvent.CHANGE ) );
		}

		private function onButtonClick( event:ButtonEvent ):void {
			event.target.active = true;
		}

		override public function destroy():void {
			destroyListButton();
			destroyListItems();
			remove( list );
			removeAll( this );
			_scrollDownButton = null;
			_scrollUpButton = null;
			_listButton = null;
			_items = null;
			_value = null;
			super.destroy();
		}

		private function destroyListButton():void {
			if( listButton ) {
				listButton.removeEventListener( ButtonEvent.BUTTON_CLICK, onListButtonClick );
				removeChild( listButton as DisplayObject );
			}
		}

		private function destroyListItems():void {
			for each( var item:DropDownListElement in items ) {
				item.removeEventListener( ButtonEvent.BUTTON_ACTIVATE, onButtonActivate );
				item.removeEventListener( ButtonEvent.BUTTON_CLICK, onButtonClick );
				list.removeChild( item as DisplayObject );
			}
		}

		public function get items():Array {
			return _items;
		}

		public function set items( items:Array ):void {
			_items = items;
			initList();
			initItems();
		}

		protected function initList():void {
			throw new AbstractMethodInvocationException( "You must override the 'initList()' method." );
		}

		private function initItems():void {
			items[items.length-1].addEventListener( ViewEvent.RENDER_COMPLETE, onLastItemRendered );
			for each( var item:DropDownListElement in items ) {
				item.addEventListener( ButtonEvent.BUTTON_ACTIVATE, onButtonActivate );
				item.addEventListener( ButtonEvent.BUTTON_CLICK, onButtonClick );
				list.addChild( item as DisplayObject );
			}
		}

		private function onLastItemRendered( event:ViewEvent ):void {
			event.target.removeEventListener( ViewEvent.RENDER_COMPLETE, onLastItemRendered );
			var wid:Number = 0;
			var padding:Padding = new Padding();
			for each( var item:DropDownListElement in items ) {
				wid = wid>item.width ? wid : item.width+padding.getPaddingWidth( item.style );
			}

			for each( item in items ) {
				item.elementWidth = wid;
			}
			_scrollDownButton.applyToStyles( "width", wid );
			_scrollUpButton.applyToStyles( "width", wid );
		}

		public function get list():Sprite {
			return _list;
		}

		public function set list( list:Sprite ):void {
			_list = list;
		}

		public function set assignedValue( value:String ):void {
			_value = value;
		}

		public function get assignedValue():String {
			return _value;
		}

		override public function get states():Dictionary {
			return null;
		}

		override public function set states( states:Dictionary ):void {
		}

		public function get dropDownHeight():Number {
			return _dropDownHeight;
		}

		public function set dropDownHeight( dropDownHeight:Number ):void {
			_dropDownHeight = dropDownHeight;
			applyToComponents( "height", dropDownHeight );
		}

		public function get dropDownWidth():Number {
			return _dropDownWidth;
		}

		public function set dropDownWidth( dropDownWidth:Number ):void {
			_dropDownWidth = dropDownWidth;
			applyToComponents( "width", dropDownWidth );
		}

		private function applyToComponents( property:String, value:* ):void {
			for each( var item:UIComponent in nestedComponents ) {
				item.applyToStyles( property, value );
			}
		}

		private function get nestedComponents():Array {
			var comps:Array = [this];
			for each( var item:DropDownListElement in items ) {
				comps[comps.length] = item;
			}
			if( listButton ) {
				comps[comps.length] = listButton;
			}
			if( scrollDownButton ) {
				comps[comps.length] = scrollDownButton;
			}
			if( scrollUpButton ) {
				comps[comps.length] = scrollUpButton;
			}
			return comps;
		}

		private function getComponentStyles( component:UIComponent ):Array {
			var styles:Array = [component.style];
			for each( var st:UIView in component.states ) {
				styles[styles.length] = st.style;
				if( st.content is TextImageContent ) {
					styles[styles.length] = TextImageContent( st.content ).style;
				}
			}
			return styles;
		}

		public function get elementFactory():DropDownListElementFactory {
			return _elementFactory;
		}

		public function set elementFactory( factory:DropDownListElementFactory ):void {
			_elementFactory = factory;
		}

		public function get params():CreationParameters {
			return _params;
		}

		public function set params( params:CreationParameters ):void {
			_params = params;
		}

		public function get scrollUpButton():Button {
			return _scrollUpButton;
		}

		public function set scrollUpButton( scrollUpButton:Button ):void {
			_scrollUpButton = scrollUpButton;
		}

		public function get scrollDownButton():Button {
			return _scrollDownButton;
		}

		public function set scrollDownButton( scrollDownButton:Button ):void {
			_scrollDownButton = scrollDownButton;
		}

		public function get disabled():Boolean {
			return _disabled;
		}

		public function set disabled( value:Boolean ):void {
			if( value && !_disabled ) {
				alpha = .7;
				mouseEnabled = mouseChildren = false;
			} else if( _disabled && !value ) {
				alpha = 1;
				mouseEnabled = mouseChildren = true;
			}
			_disabled = value;

		}
	}
}
