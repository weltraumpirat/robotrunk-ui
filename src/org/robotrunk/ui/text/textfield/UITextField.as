package org.robotrunk.ui.text.textfield {
	import flash.events.IEventDispatcher;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	import org.robotrunk.ui.core.Style;

	public interface UITextField extends IEventDispatcher {
		function get htmlText():String;

		function set htmlText( htmlText:String ):void;

		function get styleSheet():StyleSheet;

		function set styleSheet( styleSheet:StyleSheet ):void;

		function get buttonMode():Boolean;

		function set buttonMode( buttonMode:Boolean ):void;

		function get disabled():Boolean;

		function set disabled( disabled:Boolean ):void;

		function get x():Number;

		function set x( x:Number ):void;

		function get y():Number;

		function set y( y:Number ):void;

		function get width():Number;

		function set width( width:Number ):void;

		function get height():Number;

		function set height( height:Number ):void;

		function get autoSize():String;

		function set autoSize( autoSize:String ):void;

		function get linkStyle():String;

		function set linkStyle( name:String ):void;

		function get type():String;

		function set type( type:String ):void;

		function get text():String;

		function set text( text:String ):void;

		function get tabEnabled():Boolean;

		function set tabEnabled( tabEnabled:Boolean ):void;

		function get tabIndex():int;

		function set tabIndex( index:int ):void;

		function get tabChildren():Boolean;

		function set tabChildren( enable:Boolean ):void;

		function get selectionBeginIndex():int;

		function get selectionEndIndex():int;

		function setSelection( start:int, end:int ):void;

		function get multiline():Boolean;

		function set multiline( multiline:Boolean ):void;

		function get selectable():Boolean;

		function set selectable( selectable:Boolean ):void;

		function replaceSelectedText( input:String ):void;

		function getTextFormat( beginIndex:int, endIndex:int ):TextFormat;

		function get defaultTextFormat():TextFormat;

		function set defaultTextFormat( tf:TextFormat ):void;

		function get verticalAlign():String;

		function set verticalAlign( verticalAlign:String ):void;

		function get textAlign():String;

		function set textAlign( textAlign:String ):void;

		function get clazz():String;

		function set clazz( clazz:String ):void;

		function get componentType():String;

		function set componentType( componentType:String ):void;

		function get id():String;

		function set id( id:String ):void;

		function get state():String;

		function set state( state:String ):void;

		function get style():Style;

		function set style( style:Style ):void;

		function render():void;
	}
}
