package org.robotrunk.ui.text.textfield.classic {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import org.robotools.data.enumerateKeys;
	import org.robotools.graphics.drawing.VerticalAlign;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.util.ClickArea;
	import org.robotrunk.ui.core.util.Disabler;
	import org.robotrunk.ui.text.textfield.*;

	public class SmartClassicTextField extends Sprite implements UITextField {
		private var _htmlToTextParser:HtmlToTextParser = new HtmlToTextParser();
		private var _contentReducer:ContentReducer = new ContentReducer();
		private var _textToHtmlConverter:TextToHtmlConverter = new TextToHtmlConverter();

		private var _buttonModeClickArea:ClickArea;
		private var _disabledClickArea:Disabler;
		private var _disabled:Boolean;

		private var _linkstyle:String;
		private var _autoSize:String = TextFieldAutoSize.LEFT;
		private var _buttonMode:Boolean;
		private var _height:Number = 0;
		private var _width:Number = 0;

		private var _textField:BaseTextField;
		private var _verticalAlign:String;
		private var _textAlign:String;
		private var _border:Boolean;
		private var _clazz:String;
		private var _componentType:String;
		private var _id:String;
		private var _state:String;
		private var _style:Style;
		private var _htmlText:String;

		public function SmartClassicTextField() {
			super();
			textField = new BaseTextField();

			addChild( textField );

			addEventListener( Event.CHANGE, onChange );
			y = super.y;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}

		private function onAddedToStage( event:Event ):void {
			if( _htmlText != null ) {
				render();
			}
		}

		public function set htmlText( htmlText:String ):void {
			_htmlText = htmlText;
			if( stage != null ) {
				render();
			}
		}

		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			if( linkStyle ) {
				applyLinkStyle();
			}

			textField.addEventListener( Event.ENTER_FRAME, onTextFieldRender );
			textField.htmlText = _htmlText != null ? insertSpaces( applyTypographicCaseChanges( _htmlText ) ) : "";
			dispatchEvent( new Event( Event.INIT ) );
		}

		private function applyTypographicCaseChanges( htmlText:String ):String {
			return styleSheet && needsTransformation( getUniqueStyleNames( htmlText ) )
					? applyUpperCase( htmlText )
					: htmlText;
		}

		private function applyUpperCase( htmlText:String ):String {
			var content:Array = _htmlToTextParser.parse( htmlText );
			for each( var item:TextChunk in content ) {
				var style:Object = getStyleForChunk( item );
				if( style.hasOwnProperty( "typographicCase" ) && style["typographicCase"] == "uppercase" ) {
					item.text = item.text.toUpperCase();
				}
			}
			return _textToHtmlConverter.convert( _contentReducer.reduce( content ) );
		}

		private function getStyleForChunk( chunk:TextChunk ):Object {
			return styleSheet.getStyle( chunk.clazz );
		}

		private function needsTransformation( classes:Object ):Boolean {
			var affected:Array = styleClassesInText( classes );
			for each( var clazz:String in affected ) {
				if( styleSheet.getStyle( clazz ).hasOwnProperty( "typographicCase" ) ) {
					return true;
				}
			}
			return false;
		}

		private function styleClassesInText( classes:Object ):Array {
			var classNames:Array = enumerateKeys( classes );
			var affected:Array = styleSheet.styleNames.filter(
					function ( item:String, index:int, array:Array ):Boolean {
						var query:String = item.charAt( 0 ) == "." ? item.substr( 1 ) : item;
						return classNames.indexOf( query )> -1;
					}, this );
			return affected;
		}

		private function getUniqueStyleNames( htmlText:String ):Object {
			var matcher:RegExp = /class="([\w_:]+)"/g;
			var match:*;
			var classes:Object = {};
			while( (match = matcher.exec( htmlText )) != null ) {
				classes[match[1]] = match[1];
			}
			return classes;
		}

		private function onTextFieldRender( event:Event ):void {
			textField.removeEventListener( Event.ENTER_FRAME, onTextFieldRender );
			finishRendering();
		}

		public function get htmlText():String {
			return textField.htmlText;
		}

		private function applyLinkStyle():void {
			var modifiedStyleSheet:StyleSheet = copyStyleSheetFromTextField();
			for each( var id:String in ["a", "a:hover", "a:link", "a:visited"] ) {
				copyWithLinkStyle( modifiedStyleSheet, id );
			}
			styleSheet = modifiedStyleSheet;
		}

		private function copyStyleSheetFromTextField():StyleSheet {
			var modifiedStyleSheet:StyleSheet = new StyleSheet();
			var originalStyleSheet:StyleSheet = textField.styleSheet;
			for each( var name:String in originalStyleSheet.styleNames ) {
				modifiedStyleSheet.setStyle( name, originalStyleSheet.getStyle( name ) );
			}
			return modifiedStyleSheet;
		}

		private function copyWithLinkStyle( modifiedStyleSheet:StyleSheet, name:String ):void {
			modifiedStyleSheet.setStyle( name, modifiedStyleSheet.getStyle( "."+linkStyle+name ) );
		}

		private function insertSpaces( text:String ):String {
			var nbspExpression:RegExp = /#nbsp;/g;
			while( nbspExpression.test( text ) != false ) {
				text = text.replace( nbspExpression, '\u00A0' );
			}
			return text;
		}

		protected function processRenderedText():void {
		}

		protected function finishRendering():void {
			applyVerticalAlign();
			updateInvisibleClickAreas();
			dispatchRenderComplete();
		}

		protected function applyVerticalAlign():void {
			textField.y = 0;
			if( !isAutoSize ) {
				textField.width = width;
				textField.height = height;
			}
			var textHeight:Number = textField.textHeight;
			var fieldHeight:Number = height;
			var initialTextPadding:Number = getFirstCharTextOffset();
			initialTextPadding = initialTextPadding<100 ? initialTextPadding : 0;
			var maxFieldHeight:Number = textHeight+2*initialTextPadding;
			if( fieldHeight>maxFieldHeight ) {
				textField.height = maxFieldHeight;
				textField.y = verticalAlign == VerticalAlign.MIDDLE
						? ( fieldHeight-maxFieldHeight )*.5
						: verticalAlign == VerticalAlign.BOTTOM
									  ? (fieldHeight-maxFieldHeight )
									  : textField.y;
			}
			else {
				textField.y = -initialTextPadding;
			}
			_height = fieldHeight;
		}

		private function getFirstCharTextOffset():Number {
			var bounds:Rectangle = textField && textField.text != null && textField.text.length>0
					? textField.getCharBoundaries( 0 ) : new Rectangle( 0, 0, 0, 0 );
			return bounds ? bounds.top : 0;
		}

		protected function dispatchRenderComplete():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		private function onChange( ev:Event ):void {
			if( buttonMode ) {
				updateInvisibleClickAreas();
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
			return _width>0 ? _width : isVerticalAutosize ? style.width : textField.width;
		}

		private function get isVerticalAutosize():* {
			return isAutoSize && style.width>0;
		}

		override public function set width( width:Number ):void {
			_width = width;
			textField.width = width;
		}

		override public function get height():Number {
			return _height>0 ? _height : isHorizontalAutoSize ? style.height : textField.height;
		}

		private function get isHorizontalAutoSize():Boolean {
			return isAutoSize && style.height>0;
		}

		protected function get isAutoSize():Boolean {
			return style && style.autoSize != null && style.autoSize != TextFieldAutoSize.NONE && style.autoSize != "";
		}

		override public function set height( height:Number ):void {
			_height = height;
			textField.height = height;
			applyVerticalAlign();
		}

		public function get autoSize():String {
			return _autoSize;
		}

		public function set autoSize( autoSize:String ):void {
			_autoSize = autoSize;
			textField.autoSize = autoSize;
		}

		public function get linkStyle():String {
			return _linkstyle;
		}

		public function set linkStyle( name:String ):void {
			_linkstyle = name;
		}

		public function get textField():BaseTextField {
			return _textField;
		}

		public function set textField( value:BaseTextField ):void {
			_textField = value;
		}

		override public function get tabChildren():Boolean {
			return false;
		}

		override public function set tabChildren( enable:Boolean ):void {
		}

		public function get verticalAlign():String {
			return _verticalAlign;
		}

		public function set verticalAlign( verticalAlign:String ):void {
			_verticalAlign = verticalAlign;
		}

		public function getTextFormat( beginIndex:int, endIndex:int ):TextFormat {
			return textField.getTextFormat( beginIndex, endIndex );
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

		public function get defaultTextFormat():TextFormat {
			return textField.defaultTextFormat;
		}

		public function set defaultTextFormat( tf:TextFormat ):void {
			textField.defaultTextFormat = tf;
		}

		public function get multiline():Boolean {
			return textField.multiline;
		}

		public function set multiline( multiline:Boolean ):void {
			textField.multiline = multiline;
		}

		public function get selectable():Boolean {
			return textField.selectable;
		}

		public function set selectable( selectable:Boolean ):void {
			textField.selectable = selectable;
			if( selectable ) {
				buttonMode = false;
			}
		}

		public function get styleSheet():StyleSheet {
			return textField.styleSheet;
		}

		public function set styleSheet( styleSheet:StyleSheet ):void {
			textField.styleSheet = styleSheet;
			textField.htmlText = htmlText != null ? insertSpaces( applyTypographicCaseChanges( htmlText ) ) : "";
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

		public function get textAlign():String {
			return _textAlign;
		}

		public function set textAlign( textAlign:String ):void {
			_textAlign = textAlign;
			textField.autoSize = autoSize != TextFieldAutoSize.NONE
					? textAlign
					: TextFieldAutoSize.NONE;
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

		public function get border():Boolean {
			return _border;
		}

		public function set border( value:Boolean ):void {
			_border = value;
			textField.border = value;
		}

		public function get style():Style {
			return _style;
		}

		public function set style( value:Style ):void {
			_style = value;
		}
	}
}