package org.robotrunk.ui.core {
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import flashx.textLayout.formats.TextLayoutFormat;

	import org.robotools.data.copy.copyTo;
	import org.robotools.data.copy.safeCopyProperties;

	public dynamic class Style extends Proxy {
		private var _type:String;
		private var _clazz:String;
		private var _id:String;

		private var _properties:Dictionary;
		private var _keys:Array;
		private var _keysLength:int = 0;

		override flash_proxy function setProperty( name:*, value:* ):void {
			var ind:int = getItemIndex( name );
			ind = ind> -1 ? ind : ++_keysLength-1;
			_keys[ind] = name;
			_properties[name] = value;
		}

		override flash_proxy function getProperty( name:* ):* {
			return inKeys( name ) ? _properties[name] : null;
		}

		private function inKeys( name:* ):Boolean {
			return getItemIndex( name )> -1;
		}

		private function getItemIndex( name:* ):int {
			var i:int = -1;
			while( ++i<_keysLength ) {
				if( _keys && name == _keys[i] ) {
					return i;
				}
			}
			return -1;
		}

		override flash_proxy function deleteProperty( name:* ):Boolean {
			var ret:Boolean = inKeys( name ) ? delete _properties[name] : false;
			var ind:int = getItemIndex( name );
			_keys[ind] = _keys[--_keysLength];
			return ret;
		}

		override flash_proxy function hasProperty( name:* ):Boolean {
			return inKeys( name );
		}

		override flash_proxy function nextNameIndex( index:int ):int {
			return index>_keysLength-1 ? 0 : index+1;
		}

		override flash_proxy function nextName( index:int ):String {
			return String( _keys[index-1] );
		}

		override flash_proxy function nextValue( index:int ):* {
			return _properties[_keys[index-1]];
		}

		override flash_proxy function callProperty( name:*, ...rest ):* {
			return inKeys( name )
					? _properties[name].call( rest )
					: this[name]
						   ? this[name].call( rest )
						   : null;
		}

		public function Style() {
			init();
		}

		private function init():void {
			_properties = new Dictionary();
			_keys = [];
			_keysLength = 0;
		}

		public function reset():void {
			destroy();
			init();
		}

		public function destroy():void {
			_properties = null;
			_keys = null;
			_keysLength = 0;
		}

		public function toString():String {
			var str:String = "Style:\n";
			str += "id:"+id+"\n";
			str += "clazz:"+clazz+"\n";
			str += "type:"+type+"\n";
			if( _keysLength>0 ) {
				str += propertiesToString();
			}
			return str;
		}

		private function propertiesToString():String {
			var add:String = "";
			var i:int = -1;
			while( ++i<_keysLength ) {
				add += _keys[i]+":"+this[_keys[i]]+"\n";
			}
			return add;
		}

		public function toTLF():TextLayoutFormat {
			var tlf:TextLayoutFormat = new TextLayoutFormat();
			safeCopyProperties( _properties, tlf );
			if( flash_proxy::hasProperty( "padding" ) ) {
				tlf.paddingLeft = tlf.paddingRight = tlf.paddingTop = tlf.paddingBottom = _properties["padding"];
			}
			return tlf;
		}

		public function toTextFormat():TextFormat {
			var tlf:TextFormat = new TextFormat();
			safeCopyProperties( _properties, tlf );
			return tlf;
		}

		public function applyTo( item:* ):* {
			return copyTo( this, item );
		}

		public function safeApplyTo( item:* ):* {
			return safeCopyProperties( this, item );
		}

		public function get size():int {
			return _keysLength;
		}

		public function get id():String {
			return _id;
		}

		public function set id( id:String ):void {
			_id = id;
		}

		public function get clazz():String {
			return _clazz;
		}

		public function set clazz( clazz:String ):void {
			_clazz = clazz;
		}

		public function get type():String {
			return _type;
		}

		public function set type( type:String ):void {
			_type = type;
		}
	}
}
