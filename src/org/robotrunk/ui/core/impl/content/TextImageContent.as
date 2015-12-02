package org.robotrunk.ui.core.impl.content {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Content;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.text.textfield.UITextField;

	import spark.layouts.VerticalAlign;

	public class TextImageContent extends Sprite implements Content {
		private var _image:DisplayObject;

		private var _style:Style;

		private var _htmlText:String;

		public var textField:UITextField;

		[Inject]
		public var padding:Padding;

		public function render():void {
			visible = false;
			if( image ) {
				renderImage();
			}
			renderText();
		}

		protected function renderImage():void {
			addChild( image );
		}

		protected function renderText():void {
			textField.addEventListener( ViewEvent.RENDER, onTextFieldRender );
			textField.addEventListener( ViewEvent.RENDER_COMPLETE, onTextFieldRenderComplete );
			textField.autoSize = style.autoSize || TextFieldAutoSize.LEFT;
			textField.verticalAlign = style.verticalAlign == VerticalAlign.MIDDLE ? VerticalAlign.MIDDLE :
									  style.verticalAlign == VerticalAlign.BOTTOM ? VerticalAlign.BOTTOM :
									  VerticalAlign.TOP;
			textField.htmlText = htmlText;
			if( !contains( textField as DisplayObject ) ) {
				addChild( textField as DisplayObject );
			} else {
				textField.render();
			}
		}

		private function onTextFieldRender( ev:ViewEvent ):void {
			ev.stopImmediatePropagation();
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			visible = false;
		}

		private function onTextFieldRenderComplete( event:ViewEvent ):void {
			event.stopImmediatePropagation();
			adjustSize();
			positionElements();
			visible = true;
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		private function adjustSize():void {
			if( style && style.autoSize == TextFieldAutoSize.NONE ) {
				textField.width = fixedTextFieldWidth;
				textField.height = fixedTextFieldHeight;
			}
		}

		private function get fixedTextFieldWidth():Number {
			return style.width-imageWidth-padding.getPaddingWidth( style );
		}

		private function get fixedTextFieldHeight():Number {
			return style.height-padding.getPaddingHeight( style );
		}

		override public function get width():Number {
			return super.width>0 ? super.width : imageWidth+textFieldWidth;
		}

		override public function get height():Number {
			return super.height>0 && super.height>imageHeight && super.height>textFieldHeight ? super.height
					: imageHeight>textFieldHeight ? imageHeight : textFieldHeight;
		}

		public function get imageWidth():Number {
			var offset:Number = style.offset || 0;
			return image ? image.width+offset : 0;
		}

		public function get textFieldWidth():Number {
			return textField ? textField.width : 0;
		}

		public function get imageHeight():Number {
			return image ? image.height : 0;
		}

		public function get textFieldHeight():Number {
			return textField ? textField.height : 0;
		}

		private function positionElements():void {
			if( image ) {
				setXPositions();
				setYPositions();
			}
		}

		protected function setXPositions():void {
			image.x = imageX;
			textField.x = textX;
		}

		private function get textX():Number {
			return iconPosition == "left" ? image.width+offset : 0;
		}

		private function get imageX():Number {
			return iconPosition == "left" ? 0 :
				   iconPosition == "justified-right" ? justifiedXPosition :
				   rightAlignedXPosition;
		}

		private function get justifiedXPosition():Number {
			var wid:Number = style.width ? style.width : 0;
			return wid-image.width-padding.getPaddingWidth( style );
		}

		private function get rightAlignedXPosition():Number {
			return textField.width+offset;
		}

		private function get iconPosition():String {
			return style.iconPosition || "left"
		}

		private function get offset():Number {
			return style.offset || 0;
		}

		protected function setYPositions():void {
			//textField.y = textY;
			if( textField.height<image.height ) {
				textField.height = image.height;
			}
			image.y = imageY;
		}

		private function get imageY():Number {
			return imageIsTallerThanText ? 0 :
				   verticalAlign == "middle" ? heightOffset*.5 :
				   verticalAlign == "bottom" ? heightOffset :
				   0;
		}

		private function get textY():int {
			return textIsTallerThanImage ? 0 :
				   verticalAlign == "middle" ? heightOffset*.5 :
				   verticalAlign == "bottom" ? heightOffset :
				   0;
		}

		private function get textIsTallerThanImage():Boolean {
			return textField.height>image.height;
		}

		private function get imageIsTallerThanText():Boolean {
			return textField.height<image.height;
		}

		private function get verticalAlign():String {
			return style.verticalAlign || "middle";
		}

		private function get heightOffset():Number {
			return Math.abs( textField.height-image.height );
		}

		public function destroy():void {
			while( numChildren>0 ) {
				removeChildAt( 0 );
			}
			_style = null;
			_image = null;
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

		public function get image():DisplayObject {
			return _image;
		}

		public function set image( image:DisplayObject ):void {
			_image = image;
		}

		public function get style():Style {
			return _style;
		}

		public function set style( style:Style ):void {
			_style = style;
		}
	}
}
