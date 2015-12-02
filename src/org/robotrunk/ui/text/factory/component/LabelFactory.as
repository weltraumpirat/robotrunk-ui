package org.robotrunk.ui.text.factory.component {
	import flash.text.StyleSheet;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.robotrunk.ui.text.impl.LabelImpl;
	import org.robotrunk.ui.text.textfield.UITextField;

	public class LabelFactory extends AbstractTextComponentFactory {
		private var _textFieldFactory:TextFieldFactory;

		public function LabelFactory( textFieldFactory:TextFieldFactory ) {
			_textFieldFactory = textFieldFactory;
		}

		override protected function getTextComponentInstance():UIComponent {
			return parameters.injector.getInstance( LabelImpl );
		}

		override protected function createTextField( style:Style, state:String ):UITextField {
			var styleSheet:StyleSheet = parameters.styleMap.consolidatedStyleSheet;
			var tf:UITextField = isMultiLine( style )
					? _textFieldFactory.createMultiLineTextField( styleSheet )
					: _textFieldFactory.createSingleLineTextField( styleSheet );
			tf.clazz = parameters.clazz;
			tf.componentType = parameters.type;
			tf.id = parameters.id;
			tf.state = state;
			tf.style = style;
			return tf;
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject LabelImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}
	}
}
