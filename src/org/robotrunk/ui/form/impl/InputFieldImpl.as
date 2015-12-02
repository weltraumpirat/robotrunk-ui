package org.robotrunk.ui.form.impl {
	import flash.display.DisplayObject;

	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.robotrunk.ui.form.api.InputField;
	import org.robotrunk.ui.form.event.TextFieldEvent;

	public dynamic class InputFieldImpl extends UIComponentImpl implements InputField {
		public var input:UIView;
		private var _fieldWidth:Number;
		private var _fieldHeight:Number;
		private var _tabIndex:int;

		private function get content():InputTextContent {
			return input.content as InputTextContent;
		}

		public function get text():String {
			return content.text;
		}

		public function set text( text:String ):void {
			content.text = text;
		}

		public function get selectionBeginIndex():int {
			return content.selectionBeginIndex;
		}

		public function get selectionEndIndex():int {
			return content.selectionEndIndex;
		}

		public function setSelection( startIndex:int, endIndex:int ):void {
			content.setSelection( startIndex, endIndex );
		}

		public function setFocus():void {
			content.setFocus();
		}

		override protected function init():void {
			super.init();
			addChild( input as DisplayObject );
			addListeners();
			currentState = "default";
			if( style.tabIndex ) {
				input.content["tabIndex"] = style.tabIndex;
			}
		}

		private function addListeners():void {
			addEventListener( TextFieldEvent.TEXTFIELD_FOCUS, onFocus );
			addEventListener( TextFieldEvent.TEXTFIELD_BLUR, onBlur );
		}

		private function onFocus( ev:TextFieldEvent ):void {
			if( ev.currentTarget == this ) {
				currentState = "focused";
			}
		}

		private function onBlur( ev:TextFieldEvent ):void {
			if( ev.currentTarget == this ) {
				currentState = "default";
			}
		}

		override public function set currentState( state:String ):void {
			super.currentState = state;
			if( states[currentState] != null ) {
				states[currentState].mouseEnabled = false;
			}
			setChildIndex( input as DisplayObject, numChildren-1 );
		}

		public function get fieldWidth():Number {
			return _fieldWidth;
		}

		public function set fieldWidth( fieldWidth:Number ):void {
			_fieldWidth = fieldWidth;
			applyToStyle( "width", fieldWidth );
			content.textField["adjustSize"]( content.style, new Padding() );
		}

		public function get fieldHeight():Number {
			return _fieldHeight;
		}

		public function set fieldHeight( fieldHeight:Number ):void {
			_fieldHeight = fieldHeight;
			applyToStyle( "height", fieldHeight );
			content.textField["adjustSize"]( content.style, new Padding() );
		}

		override public function get tabIndex():int {
			return _tabIndex;
		}

		override public function set tabIndex( tabIndex:int ):void {
			_tabIndex = tabIndex;
			applyToStyle( "tabIndex", tabIndex );
			content.textField.tabIndex = tabIndex;
		}

		private function applyToStyle( property:String, value:* ):void {
			for each( var stl:Style in allStyles ) {
				stl[property] = value;
			}
		}

		private function get allStyles():Array {
			var styles:Array = [style, input.style, content.style];
			var i:int = styles.length-1;
			for each( var st:UIView in states ) {
				styles[++i] = st.style;
			}
			return styles;
		}
	}
}
