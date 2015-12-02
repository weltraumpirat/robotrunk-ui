package org.robotrunk.ui.slider.factory {
	import org.robotrunk.ui.button.factory.SimpleButtonFactory;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;

	public class SliderButtonFactory extends SimpleButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( SliderButtonImpl );
		}
	}
}
