package org.robotrunk.ui.text.textfield.tlf {
	import fl.text.TLFTextField;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import flashx.textLayout.elements.TextFlow;

	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.util.ClickArea;
	import org.robotrunk.ui.core.util.Disabler;
	import org.robotrunk.ui.text.*;
	import org.robotrunk.ui.text.textfield.*;

	public class SmartTLFTextField extends Sprite implements UITextField {
		private var _buttonModeClickArea:ClickArea;
		private var _disabledClickArea:Disabler;
		private var _disabled:Boolean;

		private var _linkstyle:String;
		private var _autoSize:String = TextFieldAutoSize.LEFT;
		private var _buttonMode:Boolean;
		private var _height:Number = 0;
		private var _width:Number = 0;

		private var _textField:TLFTextField;
		private var _styleSheet:StyleSheet;
		private var _textAlign:String;
		private var _clazz:String;
		private var _componentType:String;
		private var _id:String;
		private var _state:String;
		private var _style:Style;
		private var _htmlText:String;

		public function set htmlText( htmlText:String ):void {
			_htmlText = htmlText;
			if( stage != null ) {
				render();
			}
		}

		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			if( linkStyle ) {
				setLinkStyle();
			}

			textField.htmlText = htmlText;
			dispatchEvent( new Event( Event.INIT ) );
		}

		private function setLinkStyle():void {
			var flow:TextFlow = textField.textFlow;
			flow.linkActiveFormat = linkStyle;
			flow.linkHoverFormat = linkStyle;
			flow.linkNormalFormat = linkStyle;
		}

		public function set styleSheet( styleSheet:StyleSheet ):void {
			_styleSheet = styleSheet;
			var textFlow:TextFlow = textField.textFlow;
			textFlow.formatResolver = createCSSFormatResolver( styleSheet );
			updateTextFlow( textFlow );

		}

		protected function updateTextFlow( textFlow:TextFlow ):void {
			if( textFlow.flowComposer.updateAllControllers() ) {
				processRenderedText();
			} else {
				finishRendering();
			}
		}

		protected function finishRendering():void {
			updateInvisibleClickAreas();
			dispatchRenderComplete();
		}

		protected function processRenderedText():void {
			//override in subclasses
			updateTextFlow( textField.textFlow );
		}

		protected function dispatchRenderComplete():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		protected function createCSSFormatResolver( styleSheet:StyleSheet ):CSSFormatResolver {
			return new CSSFormatResolver( styleSheet );
		}

		public function SmartTLFTextField() {
			super();
			textField = new TLFTextField();
			addChild( textField );
			with( textField ) {
				condenseWhite = embedFonts = true;
				selectable = tabEnabled = false;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.SUBPIXEL;
				autoSize = TextFieldAutoSize.NONE;
				text = "";
			}
			y = super.y;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}

		private function onAddedToStage( event:Event ):void {
			if( _htmlText != null ) {
				render();
			}
		}

		private function updateInvisibleClickAreas():void {
			updateButtonModeClickArea();
			updateDisabledClickArea();
		}

		private function updateButtonModeClickArea():void {
			if( _buttonModeClickArea != null ) {
				_buttonModeClickArea.render();
			}
		}

		private function updateDisabledClickArea():void {
			if( _disabledClickArea != null ) {
				_disabledClickArea.render();
			}
		}

		override public function get buttonMode():Boolean {
			return _buttonMode;
		}

		override public function set buttonMode( buttonMode:Boolean ):void {
			_buttonMode = buttonMode;
			if( buttonMode ) {
				_buttonModeClickArea ||= new ClickArea( _textField );
			} else if( _buttonModeClickArea != null ) {
				removeButtonModeClickArea();
			}
		}

		private function removeButtonModeClickArea():void {
			_buttonModeClickArea.destroy();
			_buttonModeClickArea = null;
		}

		public function get disabled():Boolean {
			return _disabled;
		}

		public function set disabled( disabled:Boolean ):void {
			_disabled = disabled;
			if( disabled ) {
				_disabledClickArea ||= new Disabler( _textField );
			} else if( _disabledClickArea ) {
				removeDisabler();
			}
		}

		private function removeDisabler():void {
			_disabledClickArea.destroy();
			_disabledClickArea = null;
		}

		override public function set x( x:Number ):void {
			super.x = x;
			updateInvisibleClickAreas();
		}

		override public function set y( y:Number ):void {
			super.y = y;
			updateInvisibleClickAreas();
		}

		override public function get width():Number {
			return _width>0 ? _width : textField.width;
		}

		override public function set width( width:Number ):void {
			_width = width;
			textField.width = width;
		}

		override public function get height():Number {
			return _height>0 ? _height : textField.height;
		}

		override public function set height( height:Number ):void {
			_height = height;
			textField.height = height;
		}

		public function get autoSize():String {
			return _autoSize;
		}

		public function set autoSize( autoSize:String ):void {
			_autoSize = autoSize;
		}

		public function get linkStyle():String {
			return _linkstyle;
		}

		public function set linkStyle( name:String ):void {
			_linkstyle = name;
		}

		public function get textField():TLFTextField {
			return _textField;
		}

		public function set textField( value:TLFTextField ):void {
			_textField = value;
		}

		public function get type():String {
			return textField.type;
		}

		public function set type( type:String ):void {
			textField.type = type;
		}

		public function get text():String {
			return textField.text;
		}

		public function set text( text:String ):void {
			textField.text = text;
		}

		override public function get tabEnabled():Boolean {
			return textField.tabEnabled;
		}

		override public function set tabEnabled( tabEnabled:Boolean ):void {
			textField.tabEnabled = tabEnabled;
		}

		override public function get tabIndex():int {
			return textField.tabIndex;
		}

		override public function set tabIndex( index:int ):void {
			textField.tabIndex = index;
		}

		override public function get tabChildren():Boolean {
			return textField.tabChildren;
		}

		override public function set tabChildren( enable:Boolean ):void {
			textField.tabChildren = enable;
		}

		public function get selectionBeginIndex():int {
			return textField.selectionBeginIndex;
		}

		public function get selectionEndIndex():int {
			return textField.selectionEndIndex;
		}

		public function setSelection( selectionBeginIndex:int, selectionEndIndex:int ):void {
			textField.setSelection( selectionBeginIndex, selectionEndIndex );
		}

		public function replaceSelectedText( input:String ):void {
			textField.replaceSelectedText( input );
		}

		public function get multiline():Boolean {
			return textField.multiline;
		}

		public function getTextFormat( beginIndex:int, endIndex:int ):TextFormat {
			return textField.getTextFormat( beginIndex, endIndex );
		}

		public function set defaultTextFormat( tf:TextFormat ):void {
			textField.defaultTextFormat = tf;
		}

		public function get defaultTextFormat():TextFormat {
			return textField.defaultTextFormat;
		}

		public function set selectable( selectable:Boolean ):void {
			textField.selectable = selectable;
			if( selectable ) {
				buttonMode = false;
			}
		}

		public function get selectable():Boolean {
			return textField.selectable;
		}

		public function get verticalAlign():String {
			return textField.verticalAlign;
		}

		public function set verticalAlign( verticalAlign:String ):void {
			textField.verticalAlign = verticalAlign;
		}

		public function get htmlText():String {
			return textField.htmlText;
		}

		public function get styleSheet():StyleSheet {
			return _styleSheet;
		}

		public function set multiline( multiline:Boolean ):void {
			textField.multiline = multiline;
		}

		public function get textAlign():String {
			return _textAlign;
		}

		public function set textAlign( textAlign:String ):void {
			_textAlign = textAlign;
		}

		public function get clazz():String {
			return _clazz;
		}

		public function set clazz( clazz:String ):void {
			_clazz = clazz;
		}

		public function get componentType():String {
			return _componentType;
		}

		public function set componentType( componentType:String ):void {
			_componentType = componentType;
		}

		public function get id():String {
			return _id;
		}

		public function set id( id:String ):void {
			_id = id;
		}

		public function get state():String {
			return _state;
		}

		public function set state( state:String ):void {
			_state = state;
		}

		public function get style():Style {
			return _style;
		}

		public function set style( value:Style ):void {
			_style = value;
		}
	}
}