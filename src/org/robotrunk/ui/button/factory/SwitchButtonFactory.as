package org.robotrunk.ui.button.factory {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.button.impl.SwitchButtonImpl;
	import org.robotrunk.ui.core.api.UIComponent;

	public class SwitchButtonFactory extends SimpleButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( SwitchButtonImpl );
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject SwitchButtonImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}
	}
}
