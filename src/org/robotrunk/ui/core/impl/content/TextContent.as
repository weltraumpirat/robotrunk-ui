package org.robotrunk.ui.core.impl.content {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	import org.robotools.graphics.drawing.HorizontalAlign;
	import org.robotools.graphics.drawing.VerticalAlign;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Content;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.text.textfield.UITextField;

	public class TextContent extends Sprite implements Content {
		private var _style:Style;
		private var _htmlText:String;

		public var textField:UITextField;

		[Inject]
		public var padding:Padding;

		public function render():void {
			textField.addEventListener( ViewEvent.RENDER, onTextFieldRender );
			textField.addEventListener( ViewEvent.RENDER_COMPLETE, onTextFieldRenderComplete );
			adjustSize();
			textField.verticalAlign = getVerticalAlign();
			textField.textAlign = getHorizontalAlign();
			if( !contains( textField as DisplayObject ) ) {
				addChild( textField as DisplayObject );
			} else {
				textField.render();
			}
		}

		private function getVerticalAlign():String {
			return style.verticalAlign == VerticalAlign.MIDDLE
					? VerticalAlign.MIDDLE
					: style.verticalAlign == VerticalAlign.BOTTOM
						   ? VerticalAlign.BOTTOM
						   : VerticalAlign.TOP;
		}

		private function getHorizontalAlign():String {
			return style.textAlign == HorizontalAlign.CENTER
					? HorizontalAlign.CENTER
					: style.textAlign == HorizontalAlign.RIGHT
						   ? HorizontalAlign.RIGHT
						   : HorizontalAlign.LEFT;
		}

		private function onTextFieldRender( ev:ViewEvent ):void {
			ev.stopImmediatePropagation();
			textField.removeEventListener( ViewEvent.RENDER, onTextFieldRender );
			visible = false;
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
		}

		private function onTextFieldRenderComplete( event:ViewEvent ):void {
			event.stopImmediatePropagation();
			textField.removeEventListener( ViewEvent.RENDER_COMPLETE, onTextFieldRenderComplete );
			visible = true;
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		protected function adjustSize():void {
			textField.autoSize = styleAutosizeOrDefault();
			if( isNotAutosize() ) {
				setFixedWidth();
				setFixedHeight();
			} else if( isFixedWidthAutosize() ) {
				setFixedWidth();
			} else if( isFixedHeightAutosize() ) {
				setFixedHeight();
			}
		}

		private function styleAutosizeOrDefault():String {
			return style.autoSize || TextFieldAutoSize.LEFT;
		}

		private function isNotAutosize():Boolean {
			return style.autoSize == TextFieldAutoSize.NONE;
		}

		private function setFixedWidth():void {
			textField.width = style.width-padding.getPaddingWidth( style );
		}

		private function setFixedHeight():void {
			textField.height = style.height-padding.getPaddingHeight( style );
		}

		private function isFixedWidthAutosize():Boolean {
			return textField.autoSize == TextFieldAutoSize.LEFT && style.width;
		}

		private function isFixedHeightAutosize():Boolean {
			return textField.autoSize == TextFieldAutoSize.LEFT && style.height;
		}

		public function destroy():void {
			while( numChildren>0 ) {
				removeChildAt( 0 );
			}
			_style = null;
		}

		public function get htmlText():String {
			return _htmlText;
		}

		public function set htmlText( htmlText:String ):void {
			_htmlText = htmlText;
			if( textField ) {
				textField.htmlText = htmlText;
			}
		}

		public function get style():Style {
			return _style;
		}

		public function set style( style:Style ):void {
			_style = style;
		}

		override public function get width():Number {
			return textField.width;
		}

		override public function get height():Number {
			return textField.height;
		}
	}
}
