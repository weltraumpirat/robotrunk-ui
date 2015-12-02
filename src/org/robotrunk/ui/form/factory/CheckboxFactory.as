package org.robotrunk.ui.form.factory {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.button.factory.SwitchButtonFactory;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.form.impl.CheckboxImpl;

	public class CheckboxFactory extends SwitchButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( CheckboxImpl );
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject CheckboxImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}
	}
}
