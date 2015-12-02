package org.robotrunk.ui.core.util {
	import fl.managers.IFocusManager;
	import fl.managers.IFocusManagerComponent;
	import fl.managers.IFocusManagerGroup;
	import fl.text.TLFTextField;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;

	// Derived from fl.managers.FocusManager
	public class FocusManager extends EventDispatcher implements IFocusManager {
		private var _managedContainer:DisplayObjectContainer;

		private var _items:FocusableItems;

		private var _active:Boolean = false;

		private var _lastAction:String;
		private var _isTLF:Boolean;

		public function FocusManager( container:DisplayObjectContainer ) {
			_managedContainer = container;
			try {
				_isTLF = getDefinitionByName( "fl.text::TLFTextField" ) != null;
			} catch( e:Error ) {
				_isTLF = false;
			}
			if( _managedContainer ) {
				activate();
			}
		}

		public function activate():void {
			if( managedContainer && !active ) {
				active = true;
				addListeners();

				_items ||= new FocusableItems();
				_items.manager = this;
				if( _items.lastFocusedItem ) {
					setFocus( _items.lastFocusedItem );
				}
			}
		}

		public function deactivate():void {
			if( managedContainer && active ) {
				active = false;
				removeListeners();
				_items.destroy();
			}
		}

		public function getFocus():InteractiveObject {
			return findFocusManagerComponent( managedContainer.stage.focus );
		}

		public function setFocus( component:InteractiveObject ):void {
			focusItem( component );
		}

		public function findFocusManagerComponent( component:InteractiveObject ):InteractiveObject {
			var activeItem:InteractiveObject = parentFocusManagerOrNull( component );
			return activeItem ? activeItem : component;
		}

		public function getNextFocusManagerComponent( backward:Boolean = false ):InteractiveObject {

			var candidates:Array = _items.candidates;
			var focusedItem:InteractiveObject = managedContainer.stage.focus ? managedContainer.stage.focus : null;
			var nextIndex:int = getNextIndex( focusedItem, backward );
			return findFocusManagerComponent( candidates[nextIndex] );
		}

		private function getNextIndex( focusedItem:InteractiveObject, backward:Boolean ):int {
			var currentFocusItem:* = findFocusManagerComponent( focusedItem );
			var currentIndex:int = _items.candidates.indexOf( currentFocusItem );
			var groupName:String = getGroupName( currentFocusItem );
			return backward ? getNextIndexBackward( currentIndex, groupName ) :
				   getNextIndexForward( currentIndex, groupName );
		}

		private function addListeners():void {
			with( managedContainer ) {
				addEventListener( Event.ADDED, onAdded, false, 0, true );
				addEventListener( Event.REMOVED, onRemoved, false, 0, true );
				addEventListener( FocusEvent.FOCUS_IN, onFocusIn, true, 0, true );
				addEventListener( FocusEvent.FOCUS_OUT, onFocusOut, true, 0, true );
				addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
				addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, true, 0, true );
			}

			with( managedContainer.stage ) {
				addEventListener( FocusEvent.MOUSE_FOCUS_CHANGE, onMouseFocusChange, false, 0, true );
				addEventListener( FocusEvent.KEY_FOCUS_CHANGE, onKeyFocusChange, false, 0, true );
				addEventListener( Event.ACTIVATE, onActivate, false, 0, true );
				addEventListener( Event.DEACTIVATE, onDeactivate, false, 0, true );
			}
		}

		private function removeListeners():void {
			with( managedContainer ) {
				removeEventListener( Event.ADDED, onAdded, false );
				removeEventListener( Event.REMOVED, onRemoved, false );
				removeEventListener( FocusEvent.FOCUS_IN, onFocusIn, true );
				removeEventListener( FocusEvent.FOCUS_OUT, onFocusOut, true );
				removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false );
				removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, true );
			}

			with( managedContainer.stage ) {
				removeEventListener( FocusEvent.MOUSE_FOCUS_CHANGE, onMouseFocusChange, false );
				removeEventListener( FocusEvent.KEY_FOCUS_CHANGE, onKeyFocusChange, false );
				removeEventListener( Event.ACTIVATE, onActivate, false );
				removeEventListener( Event.DEACTIVATE, onDeactivate, false );
			}
		}

		private function focusItem( item:* ):void {
			//trace( "focusItem:"+getPath( item ) );
			var component:IFocusManagerComponent = item as IFocusManagerComponent;
			if( component ) {
				component.setFocus();
			} else {
				managedContainer.stage.focus = _items.lastFocusedItem;
			}

		}

		private function getPath( item:* ):String {
			var obj:* = item;
			var ret:String = "";
			while( obj != null && obj.parent != null ) {
				ret += obj.name+" "+obj+" | ";
				obj = obj.parent;
			}
			return ret;
		}

		private function parentFocusManagerOrNull( component:InteractiveObject ):InteractiveObject {
			return component ? isActiveFocusManagerComponent( component ) ? component :
							   (component.parent ? parentFocusManagerOrNull( component.parent ) : null) : null;
		}

		private function getGroupName( currentFocusItem:* ):String {
			var group:IFocusManagerGroup = currentFocusItem as IFocusManagerGroup;
			return group ? group.groupName : "";
		}

		private function getNextIndexBackward( startIndex:int, groupName:String ):int {
			var i:int = startIndex> -1 ? startIndex : _items.candidates.length;
			while( --i> -1 ) {
				var ret:int = getCandidateOrGroupIndex( i, groupName );
				if( ret != -1 ) {
					return ret;
				}
			}
			return getNextIndexBackward( _items.candidates.length, groupName );
		}

		private function getNextIndexForward( startIndex:int, groupName:String ):int {
			var i:int = startIndex;
			while( ++i<_items.candidates.length ) {
				var ret:int = getCandidateOrGroupIndex( i, groupName );
				if( ret != -1 ) {
					return ret;
				}
			}
			return getNextIndexForward( -1, groupName );
		}

		private function isActiveFocusManagerComponent( component:InteractiveObject ):Boolean {
			var item:IFocusManagerComponent = component as IFocusManagerComponent;
			return item && item.focusEnabled;
		}

		private function onAdded( event:Event ):void {
			var target:DisplayObject = event.target as DisplayObject;
			if( target.stage ) {
				_items.addFocusables( target );
			}
		}

		private function onRemoved( event:Event ):void {
			_items.removeFocusables( event.target as DisplayObject );
		}

		private function onFocusIn( event:FocusEvent ):void {
			//event.stopImmediatePropagation();
			if( _active ) {
				var target:InteractiveObject = event.target as InteractiveObject;
				if( managedContainer.contains( target ) ) {
					_items.lastFocusedItem = findFocusManagerComponent( target );
				}
			}
		}

		private function onFocusOut( event:FocusEvent ):void {
			//event.stopImmediatePropagation();
		}

		private function onMouseDown( event:MouseEvent ):void {
			if( _active && !event.isDefaultPrevented() && getPath( event.target ).indexOf( "VirtualKeyboard" ) == -1 ) {
				focusTopLevelItem( event.target as InteractiveObject );
			}
		}

		private function focusTopLevelItem( item:InteractiveObject ):void {
			//trace("focusTopLevelItem:"+getPath(item));
			var target:InteractiveObject = getTopLevelFocusTarget( item );
			if( target != null ) {
				focusTarget( target );
				_lastAction = "MOUSEDOWN";
			}
		}

		private function focusTarget( target:InteractiveObject ):void {
			if( (target != _items.lastFocusedItem || _lastAction == "ACTIVATE") && !(isTextField( target )) ) {
				setFocus( target );
			}
		}

		private function onKeyDown( event:KeyboardEvent ):void {
			if( _active && event.keyCode == Keyboard.TAB ) {
				_lastAction = "KEY";
				_items.sort = true;
			}
		}

		private function onActivate( event:Event ):void {
			if( _active ) {
				if( _items.lastFocusedItem ) {
					focusItem( _items.lastFocusedItem );
				}
				_lastAction = "ACTIVATE";
			}
		}

		private function onDeactivate( event:Event ):void {
		}

		private function onMouseFocusChange( event:FocusEvent ):void {
			if( _active && !isTextField( event.relatedObject ) ) {
				event.preventDefault();
			}
		}

		private function isTextField( obj:InteractiveObject ):Boolean {
			return obj is TextField || ( isTLF && obj is TLFTextField);
		}

		private function get isTLF():Boolean {
			return _isTLF;
		}

		private function onKeyFocusChange( event:FocusEvent ):void {
			if( _active && (event.keyCode == Keyboard.TAB || event.keyCode == 0) && !event.isDefaultPrevented() ) {
				event.preventDefault();
				setFocusToNextObject( event );
			}
		}

		private function isValidFocusCandidate( item:DisplayObject, groupName:String ):Boolean {
			if( isEnabledAndVisible( item ) ) {
				var group:IFocusManagerGroup = item as IFocusManagerGroup;
				return group == null || group.groupName != groupName;
			} else {
				return false;
			}
		}

		private function isEnabledAndVisible( item:* ):Boolean {
			return item.visible && item.tabEnabled;
		}

		private function setFocusToNextObject( event:FocusEvent ):void {
			if( _items.hasFocusableObjects() ) {
				var item:InteractiveObject = getNextFocusManagerComponent( event.shiftKey );
				if( item ) {
					setFocus( item );
				}
			}
		}

		private function getCandidateOrGroupIndex( index:int, groupName:String ):int {
			var candidate:* = _items.candidates[index];
			return isValidFocusCandidate( candidate, groupName ) ? getCandidateIndex( candidate ) : -1;
		}

		private function getCandidateIndex( candidate:* ):int {
			var component:InteractiveObject = findFocusManagerComponent( candidate );
			var group:IFocusManagerGroup = component as IFocusManagerGroup;
			return group ? getGroupIndex( group.groupName ) : _items.candidates.indexOf( component );
		}

		private function getGroupIndex( groupName:String ):int {
			var i:int = -1;
			while( ++i<_items.candidates.length ) {
				var group:IFocusManagerGroup = _items.candidates[i];
				if( group && group.groupName == groupName && group.selected ) {
					break;
				}
			}
			return i;
		}

		private function getTopLevelFocusTarget( item:InteractiveObject ):InteractiveObject {
			var current:* = item;
			while( current && current != managedContainer ) {
				if( isFocusTarget( current as IFocusManagerComponent ) ) {
					return current;
				} else {
					current = current.parent;
				}
			}
			return current;
		}

		private function isFocusTarget( component:IFocusManagerComponent ):Boolean {
			return component && component.focusEnabled && component.mouseFocusEnabled;
		}

		public function get nextTabIndex():int {
			return 0;
		}

		public function get managedContainer():DisplayObjectContainer {
			return _managedContainer;
		}

		public function set managedContainer( value:DisplayObjectContainer ):void {
			_managedContainer = value;
		}

		public function get active():Boolean {
			return _active;
		}

		public function set active( active:Boolean ):void {
			_active = active;
		}

		public function destroy():void {
			_active = false;
			if( _items ) {
				_items.destroy();
			}
			_items = null;
			_lastAction = null;
			_managedContainer = null;
		}

		public function get items():FocusableItems {
			return _items;
		}

		public function set items( value:FocusableItems ):void {
			_items = value;
		}

		public function get lastAction():String {
			return _lastAction;
		}

		public function set lastAction( value:String ):void {
			_lastAction = value;
		}
	}
}
