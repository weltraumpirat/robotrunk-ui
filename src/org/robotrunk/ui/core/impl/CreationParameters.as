package org.robotrunk.ui.core.impl {
	import flash.utils.Dictionary;

	import org.robotools.data.copy.safeGetProperty;
	import org.robotrunk.ui.core.StyleMap;
	import org.swiftsuspenders.Injector;

	public class CreationParameters {
		public var type:String = null;

		public var clazz:String = null;

		public var id:String = null;

		public var optional:Boolean = false;

		public var states:Array = ["default"];

		public var injector:Injector;

		public var styleMap:StyleMap = null;

		private var _map:String;

		private var _stateNames:String;

		public function CreationParameters( injector:Injector, injectParameters:Dictionary ) {
			this.injector = injector;
			type = safeGetProperty( injectParameters, "kind" );
			id = safeGetProperty( injectParameters, "name" );
			clazz = safeGetProperty( injectParameters, "style" );
			optional = injectParameters.hasOwnProperty( "optional" ) ? injectParameters.optional : false;

			_map = safeGetProperty( injectParameters, "map" );
			styleMap = injector.getInstance( StyleMap, _map ? _map : "default" );
			_stateNames = safeGetProperty( injectParameters, "states" );
			states = _stateNames ? _stateNames.split( "," ) : ["default"];
		}

		public function destroy():void {
			type = null;
			clazz = null;
			id = null;
			optional = false;
			states = null;
			injector = null;
			styleMap = null;
		}

		public function asDictionary():Dictionary {
			var dict:Dictionary = new Dictionary();
			dict.kind = clazz;
			dict.style = type;
			dict.name = id;
			dict.optional = optional;
			dict.map = _map ? _map : "default";
			dict.states = _stateNames;
			return dict;
		}

		public function toString():String {
			var str:String = "CreationParameters:\n";
			str += "type:"+type+"\n";
			str += "id:"+id+"\n";
			str += "clazz:"+clazz+"\n";
			str += "optional:"+optional+"\n";
			str += "map:"+_map+"\n";
			str += "states:"+_stateNames+"\n";
			return str;
		}
	}
}
