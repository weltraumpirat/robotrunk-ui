package org.robotrunk.ui.buttonbar.factory {
	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.factory.AbstractComponentFactory;

	public class AbstractButtonBarFactory extends AbstractComponentFactory {
		override protected function createComponent():UIComponent {
			var component:UIComponent;
			component = getButtonBarInstance();
			return component;
		}

		protected function getButtonBarInstance():UIComponent {
			throw new AbstractMethodInvocationException( "You must override the 'getButtonInstance' method." );
			return null;
		}
	}
}
