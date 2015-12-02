package org.robotrunk.ui.form.impl {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.Content;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.form.UIComponentInputTextField;

	public class InputTextContent extends Sprite implements Content {
		public var textField:UIComponentInputTextField;

		private var _style:Style;

		[Inject]
		public var position:Position;

		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			renderTextField();
			applyPosition();
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		public function renderTextField():void {
			addChild( textField as DisplayObject );
		}

		public function applyPosition():void {
			position.forTarget( this ).within( style ).withPadding().apply();
		}

		public function get text():String {
			return textField.text;
		}

		public function set text( text:String ):void {
			textField.text = text;
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

		public function setFocus():void {
			textField.setFocus();
		}

		public function get style():Style {
			return _style;
		}

		public function set style( style:Style ):void {
			_style = style;
		}

		override public function get tabIndex():int {
			return textField.tabIndex;
		}

		override public function set tabIndex( tabIndex:int ):void {
			textField.tabIndex = tabIndex;
		}
	}
}
