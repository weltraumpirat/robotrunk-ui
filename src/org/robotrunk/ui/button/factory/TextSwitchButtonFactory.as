package org.robotrunk.ui.button.factory {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.button.impl.TextSwitchButtonImpl;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;

	public class TextSwitchButtonFactory extends TextButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( TextSwitchButtonImpl );
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
			super.fail( e );
		}

		public function TextSwitchButtonFactory( textFieldFactory:TextFieldFactory ) {
			super( textFieldFactory );
		}
	}
}
