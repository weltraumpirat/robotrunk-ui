package org.robotrunk.ui.text.factory.component {
	import flash.text.StyleSheet;

	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.robotrunk.ui.text.textfield.UITextField;

	public class AbstractRichTextElementFactory extends AbstractTextComponentFactory {
		private var _textFieldFactory:TextFieldFactory;

		public function AbstractRichTextElementFactory( textFieldFactory:TextFieldFactory ) {
			_textFieldFactory = textFieldFactory;
		}

		override protected function createTextField( style:Style, state:String ):UITextField {
			var styleSheet:StyleSheet = parameters.styleMap.consolidatedStyleSheet;
			var tf:UITextField = isWordWrap( style )
					? _textFieldFactory.createMultiLineTextField( styleSheet )
					: _textFieldFactory.createMultiLineNoWrapTextField( styleSheet );
			tf.clazz = parameters.clazz;
			tf.componentType = parameters.type;
			tf.id = parameters.id;
			tf.state = state;
			tf.style = style;
			tf.selectable = isSelectable( style );
			return tf;
		}
	}
}
