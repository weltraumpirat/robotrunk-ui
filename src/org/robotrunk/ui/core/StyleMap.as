package org.robotrunk.ui.core {

	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	import org.robotools.data.copy.copyProperties;
	import org.robotools.data.enumerateKeys;
	import org.robotools.data.parsing.parseToColor;
	import org.robotools.data.parsing.parseToFloat;
	import org.robotools.data.parsing.parseToInt;
	import org.robotools.text.trim;
	import org.robotrunk.common.error.MissingValueException;
	import org.robotrunk.common.error.NullPointerException;

	public class StyleMap {
		private var _styleSheet:StyleSheet;
		private var _consolidatedStyleSheet:StyleSheet;

		public static function copyStyles( from:StyleSheet, to:StyleSheet ):StyleSheet {
			for each( var name:String in from.styleNames ) {
				to.setStyle( name, from.getStyle( name ) );
			}
			return to;
		}

		public function getStyleByName( name:String ):Object {
			if( !_styleSheet ) {
				throw new NullPointerException( "No StyleSheet was set for StyleMap." );
			}
			if( !name ) {
				throw new MissingValueException( "Tried to get style for 'null'." );
			}
			return _styleSheet.getStyle( name );
		}

		public function getStyleAsTextFormatOrNull( name:String ):TextFormat {
			var style:Object = getStyleByName( name );
			return style != null ? _styleSheet.transform( style ) : null;
		}

		public function getStyleCascaded( type:String, clazz:String, id:String ):Style {
			var style:Style = new Style;
			style = type ? combinedStyle( type, style ) : style;
			style = clazz ? combinedStyle( "."+clazz, style ) : style;
			style = id ? combinedStyle( "#"+id, style ) : style;
			style.type = type;
			style.clazz = clazz;
			style.id = id;
			return style;
		}

		public function getComponentStyleCascaded( type:String, clazz:String, id:String ):Style {
			return transformValues( getStyleCascaded( type, clazz, id ) );
		}

		private function transformValues( style:Style ):Style {
			var retStyle:Style = new Style();
			for( var prop:String in style ) {
				retStyle[prop] = transformedValueOf( trim( style[prop] ) );
			}
			return retStyle;
		}

		private function transformedValueOf( value:String ):* {
			return isNumeric( value ) ? numericValueOf( value ) :
				   isBoolean( value ) ? booleanValueOf( value ) : value != "auto" ? value : undefined;
		}

		private function booleanValueOf( value:String ):Boolean {
			return value == "true";
		}

		private function isBoolean( value:String ):Boolean {
			return value == "true" || value == "false";
		}

		private function isNumeric( value:String ):* {
			return /^[0-9#.-]/.exec( value );
		}

		private function numericValueOf( value:String ):* {
			return value.charAt( 0 ) == "#" ? parseToColor( value ) :
				   value.indexOf( "." )> -1 ? parseToFloat( value ) : parseToInt( value );
		}

		private function combinedStyle( nameOfStyleToAdd:String, style:Style ):Style {
			if( !nameOfStyleToAdd ) {
				return style;
			}
			var combined:Style = copyProperties( style, new Style() );
			var ind:int = nameOfStyleToAdd.indexOf( ":" );
			if( ind> -1 ) {
				combined = combinedStyle( nameOfStyleToAdd.substr( 0, ind ), combined );
			}
			combined = copyProperties( getStyleByName( nameOfStyleToAdd ), combined );
			return combined;
		}

		public function toCssString():String {
			var ret:String = "";
			for each( var name:String in _styleSheet.styleNames.sort() ) {
				ret += styleToCssString( name );
			}
			return ret;
		}

		private function styleToCssString( name:String ):String {
			var style:Object = getStyleByName( name );
			var ret:String = name+"{";
			ret += allPropertiesToString( style );
			ret += "}\n";
			return ret;
		}

		public function allPropertiesToString( style:* ):String {
			var ret:String = "";
			for each( var propertyName:String in enumerateKeys( style ).sort() ) {
				ret += propertyName+":"+style[propertyName]+";";
			}
			return ret;
		}

		public function destroy():void {
			_styleSheet = null;
		}

		public function get styleSheet():StyleSheet {
			return _styleSheet;
		}

		public function set styleSheet( styleSheet:StyleSheet ):void {
			_styleSheet = styleSheet;
		}

		public function get consolidatedStyleSheet():StyleSheet {
			if( _consolidatedStyleSheet == null ) {
				_consolidatedStyleSheet = consolidateStyleSheet( styleSheet );
			}
			return _consolidatedStyleSheet;
		}

		private function consolidateStyleSheet( unconsolidated:StyleSheet ):StyleSheet {
			var consolidated:StyleSheet = new StyleSheet();
			for each( var name:String in unconsolidated.styleNames ) {
				consolidated.setStyle( name, consolidatedStyle( name, unconsolidated ) );
			}
			return consolidated;
		}

		private function consolidatedStyle( name:String, unconsolidated:StyleSheet ):* {
			return isPseudoClass( name )
					? inheritedStyle( name, unconsolidated )
					: unconsolidated.getStyle( name );
		}

		private function isPseudoClass( name:String ):Boolean {
			return name.indexOf( ":" )> -1;
		}

		private function inheritedStyle( name:String, unconsolidated:StyleSheet ):* {
			var style:Object = {};
			style = copyProperties( baseStyle( unconsolidated, name ), style );
			style = copyProperties( unconsolidated.getStyle( name ), style );
			return style;
		}

		private function baseStyle( unconsolidated:StyleSheet, name:String ):* {
			return unconsolidated.getStyle( baseStyleName( name ) );
		}

		private function baseStyleName( name:String ):String {
			return name.substr( 0, name.indexOf( ":" ) );
		}
	}
}
