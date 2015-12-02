package org.robotrunk.ui.form.factory {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.button.factory.TextSwitchButtonFactory;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.form.impl.RadioButtonElementImpl;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;

	public class RadioButtonElementFactory extends TextSwitchButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( RadioButtonElementImpl );
		}

		override protected function fail( e:Error ):void {
			var msg:String = parameters != null
					? "Could not inject TextSwitchButtonImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states
					: "No parameters injected!";
			try {
				parameters.injector.getInstance( Logger ).warn( msg );
			}
			catch( ignore:Error ) {
				trace( msg, "No Logger:"+ignore.getStackTrace() );
			}
			if( parameters != null && !parameters.optional ) {
				throw( e );
			}
		}

		public function RadioButtonElementFactory( textFieldFactory:TextFieldFactory ) {
			super( textFieldFactory );
		}
	}
}
