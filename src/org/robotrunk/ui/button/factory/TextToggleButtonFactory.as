package org.robotrunk.ui.button.factory {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.button.impl.TextToggleButtonImpl;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;

	public class TextToggleButtonFactory extends TextButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( TextToggleButtonImpl );
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject TextToggleButtonImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}

		public function TextToggleButtonFactory( textFieldFactory:TextFieldFactory ) {
			super( textFieldFactory );
		}
	}
}
