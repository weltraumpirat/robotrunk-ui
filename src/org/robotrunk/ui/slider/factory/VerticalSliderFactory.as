package org.robotrunk.ui.slider.factory {
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.content.EmptyContent;
	import org.robotrunk.ui.slider.api.Slider;
	import org.robotrunk.ui.slider.api.SliderButton;
	import org.robotrunk.ui.slider.impl.VerticalSliderImpl;

	public class VerticalSliderFactory extends AbstractSliderFactory {
		[Inject]
		public var buttonFactory:SliderButtonFactory;

		override protected function getSliderInstance():Slider {
			return parameters.injector.getInstance( VerticalSliderImpl );
		}

		override protected function getButtonInstance():SliderButton {
			var params:Dictionary = parameters.asDictionary();
			params.kind = parameters.type+"button";
			params.style = parameters.clazz+"button";
			params.name = parameters.id+"button";
			return buttonFactory.create( parameters.injector, params ) as SliderButton;
		}

		override protected function getViewContent( view:UIView ):Sprite {
			return new EmptyContent();
		}

		public function VerticalSliderFactory() {
			buttonFactory = new SliderButtonFactory();
		}
	}
}
