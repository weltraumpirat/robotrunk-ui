package org.robotrunk.ui.form.factory {
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.factory.AbstractComponentFactory;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.form.api.DropDownList;
	import org.robotrunk.ui.form.impl.DropDownListImpl;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;

	public class DropDownListFactory extends AbstractComponentFactory {

		override protected function createComponent():UIComponent {
			var component:DropDownList;
			component = getListInstance();
			component.style = getComponentStyle();
			return component;
		}

		private function getListInstance():DropDownList {
			var instance:DropDownListImpl = parameters.injector.getInstance( DropDownListImpl );
			instance.elementFactory = new DropDownListElementFactory( parameters.injector.getInstance( TextFieldFactory ) );
			instance.params = new CreationParameters( parameters.injector, parameters.asDictionary() );
			return instance;
		}
	}
}
