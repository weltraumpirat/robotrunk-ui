package org.robotrunk.ui.core.util {
	import fl.managers.IFocusManagerComponent;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;

	internal class FocusableItems {
		private var _manager:FocusManager;

		private var _focusableItems:Dictionary;

		private var _sort:Boolean;

		private var _lastFocusedItem:*;

		private var _focusableCandidates:Array;

		public function FocusableItems( manager:FocusManager = null ) {
			this.manager = manager;
		}

		public function get manager():FocusManager {
			return _manager;
		}

		public function set manager( manager:FocusManager ):void {
			if( manager ) {
				if( _manager ) {
					destroy();
				}
				_manager = manager;
				_focusableItems ||= new Dictionary( true );
				addFocusables( manager.managedContainer );
			} else {
				destroy();
			}
		}

		public function destroy():void {
			_manager = null;
			_focusableItems = null;
			_lastFocusedItem = null;
			_focusableCandidates = null;
			_sort = false;
		}

		public function hasFocusableObjects():Boolean {
			var item:* = null;
			for( item in _focusableItems ) {
				if( item ) {
					return true;
				}
			}
			return false;
		}

		public function addFocusables( item:DisplayObject ):void {
			if( item ) {
				addFocusable( item );
				if( isTabVisibleInDisplayTree( item ) ) {
					addChildFocusables( item as DisplayObjectContainer );
				}
			}
		}

		private function addFocusable( item:DisplayObject ):void {
			if( isEligibleFocusable( item ) ) {
				_focusableItems[item] = true;
			}
			_sort = true;
			addTabListeners( item );
		}

		private function isTabVisibleInDisplayTree( item:DisplayObject ):Boolean {
			var container:DisplayObjectContainer = item.parent;
			return container && !(container is Stage) ?
				   container.tabChildren && isTabVisibleInDisplayTree( container ) : true;
		}

		private function addChildFocusables( container:DisplayObjectContainer ):void {
			if( container ) {
				container.addEventListener( Event.TAB_CHILDREN_CHANGE, onTabChildrenChange, false, 0, true );

				var i:int = -1;
				while( ++i<container.numChildren ) {
					tryToAddChildFocusable( container, i );
				}
			}
		}

		private function tryToAddChildFocusable( container:DisplayObjectContainer, i:int ):void {
			try {
				addFocusables( container.getChildAt( i ) );
			} catch( ignore:SecurityError ) {
				// ignore inaccessible objects (different application domain)
			}
		}

		public function removeFocusables( removedItem:DisplayObject ):void {
			removeChildFocusables( removedItem as DisplayObjectContainer );
			if( isRegisteredFocusable( removedItem ) ) {
				removeFocusable( removedItem );
			}
		}

		private function removeChildFocusables( container:DisplayObjectContainer ):void {
			if( container ) {
				removeTabListeners( container );
				for( var item:* in _focusableItems ) {
					if( item && container == item.parent ) {
						removeFocusables( item );
					}
				}
			}
		}

		private function isRegisteredFocusable( removedItem:DisplayObject ):Boolean {
			return (removedItem is IFocusManagerComponent || removedItem is InteractiveObject) && _focusableItems[removedItem] == true;
		}

		private function removeFocusable( removedItem:* ):void {
			if( removedItem == _lastFocusedItem ) {
				_lastFocusedItem = null;
			}
			removedItem.removeEventListener( Event.TAB_ENABLED_CHANGE, onTabEnabledChange, false );
			delete _focusableItems[removedItem];
			_sort = true;
		}

		private function isEligibleFocusable( item:DisplayObject ):Boolean {
			var component:IFocusManagerComponent = item is IFocusManagerComponent ? item as IFocusManagerComponent :
												   null;
			var interactive:InteractiveObject = item is InteractiveObject ? item as InteractiveObject : null;
			return component ? isEligibleComponent( component ) :
				   interactive ? isEligibleInteractiveObject( interactive ) : false;
		}

		private function isEligibleComponent( component:IFocusManagerComponent ):Boolean {
			return component.focusEnabled && component.tabEnabled && isTabVisibleInDisplayTree( component as DisplayObject );
		}

		private function isEligibleInteractiveObject( interactive:InteractiveObject ):Boolean {
			return interactive.tabEnabled && manager.findFocusManagerComponent( interactive ) == interactive;
		}

		private function addTabListeners( item:* ):void {
			item.addEventListener( Event.TAB_ENABLED_CHANGE, onTabEnabledChange, false, 0, true );
			item.addEventListener( Event.TAB_INDEX_CHANGE, onTabIndexChange, false, 0, true );
		}

		private function removeTabListeners( item:* ):void {
			item.removeEventListener( Event.TAB_CHILDREN_CHANGE, onTabChildrenChange, false );
			item.removeEventListener( Event.TAB_INDEX_CHANGE, onTabIndexChange, false );
		}

		private function onTabEnabledChange( event:Event ):void {
			_sort = true;
			changeTabEnabledState( event.target as InteractiveObject );
		}

		private function changeTabEnabledState( item:InteractiveObject ):void {
			if( item.tabEnabled && isTabVisibleInDisplayTree( item ) ) {
				register( item );
			} else {
				unregister( item );
			}
		}

		private function onTabChildrenChange( event:Event ):void {
			if( event.target == event.currentTarget ) {
				_sort = true;
				changeTabChildrenState( event.target as DisplayObjectContainer );
			}
		}

		private function changeTabChildrenState( container:DisplayObjectContainer ):void {
			if( container.tabChildren ) {
				if( isTabVisibleInDisplayTree( container ) ) {
					addChildFocusables( container );
				}
			} else {
				removeFocusables( container );
			}
		}

		private function onTabIndexChange( event:Event ):void {
			_sort = true;
		}

		private function register( item:InteractiveObject ):void {
			item.focusRect = false;
			_focusableItems[item] = true;
		}

		private function unregister( item:InteractiveObject ):void {
			if( _focusableItems[item] != undefined ) {
				delete _focusableItems[item];
			}
		}

		private function sortedFocusableItems():Array {
			var sort:FocusableItemsSorter = new FocusableItemsSorter( _manager );
			var items:Array = sort.sort( _focusableItems );
			sort.destroy();
			return items;
		}

		private function populateFocusableCandidates( arr:Array ):void {
			_focusableCandidates = [];
			for each( var obj:Object in arr ) {
				_focusableCandidates.push( obj.item );
			}
		}

		public function get candidates():Array {
			if( _sort ) {
				populateFocusableCandidates( sortedFocusableItems() );
				_sort = false;
			}
			return _focusableCandidates;
		}

		public function get lastFocusedItem():* {
			return _lastFocusedItem;
		}

		public function set lastFocusedItem( lastFocusedItem:* ):void {
			_lastFocusedItem = lastFocusedItem;
		}

		public function get sort():Boolean {
			return _sort;
		}

		public function set sort( sort:Boolean ):void {
			_sort = sort;
		}
	}
}

import flash.display.DisplayObject;
import flash.utils.Dictionary;

import org.robotools.text.leadingZeros;
import org.robotrunk.ui.core.util.FocusManager;

internal class FocusableItemsSorter {
	private var _itemsByTabIndex:Array;

	private var _itemsByDepth:Array;

	private var _manager:FocusManager;

	public function destroy():void {
		_manager = null;
		_itemsByDepth = null;
		_itemsByTabIndex = null;
	}

	public function sort( items:Dictionary ):Array {
		for( var item:* in items ) {
			placeItem( item );
		}

		return sortedItems;
	}

	private function get sortedItems():* {
		return _itemsByTabIndex.length>0 ? _itemsByTabIndex.sortOn( "index", Array.NUMERIC ) :
			   _itemsByDepth.sortOn( "depth" );
	}

	private function placeItem( item:* ):void {
		if( isValidTabIndex( item.tabIndex ) ) {
			_itemsByTabIndex.push( {item: item, index: item.tabIndex} );
		} else {
			_itemsByDepth.push( {item: item, depth: getDepthAsString( item )} );
		}
	}

	private function isValidTabIndex( index:* ):Boolean {
		var n:Number = Number( index );
		return !isNaN( n ) && n>0;
	}

	private function getDepthAsString( item:DisplayObject ):String {
		return isNestedItem( item ) ? getItemDepthAsString( item ) : "";
	}

	private function isNestedItem( item:DisplayObject ):Boolean {
		return item != _manager.managedContainer && item.parent;
	}

	private function getItemDepthAsString( item:DisplayObject ):String {
		var parentDepth:String = getDepthAsString( item.parent );
		var index:int = item.parent.getChildIndex( item );
		var indexString:String = index.toString( 16 );
		var depth:String = leadingZeros( indexString, 4 );
		var itemDepth:String = parentDepth+depth;
		return itemDepth;
	}

	public function FocusableItemsSorter( manager:FocusManager ) {
		_itemsByDepth = [];
		_itemsByTabIndex = [];
		_manager = manager;
	}
}
