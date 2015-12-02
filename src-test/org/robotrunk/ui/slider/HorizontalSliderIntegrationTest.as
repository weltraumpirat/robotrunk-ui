package org.robotrunk.ui.slider {
	import avmplus.getQualifiedClassName;

	import flash.text.StyleSheet;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.slider.api.Slider;
	import org.robotrunk.ui.slider.conf.SliderExtension;
	import org.robotrunk.ui.slider.impl.HorizontalSliderImpl;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.framework.impl.Context;

	public class HorizontalSliderIntegrationTest {
		[Inject]
		public var injector:Injector;

		[Inject(name="slider", kind="slider", style="horizontal", map="slider")]
		public var slider:Slider;

		public var context:Context;

		public var css:String = "slider{} .horizontal{width:110px; height:20px;} .vertical{width:20px; height:110px;} #slider{}";

		[Test]
		public function checkObjectCreation():void {
			context = new Context();
			context.extend( MVCSBundle, SliderExtension );
			context.configure( this );
			var provider:UIComponentProvider = context.injector.getInstance( UIComponentProvider,
																			 getQualifiedClassName( HorizontalSliderImpl ) );
			var styleMap:StyleMap = new StyleMap();
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( css );
			styleMap.styleSheet = styleSheet;
			context.injector.map( StyleMap, "slider" ).toValue( styleMap );
			context.injector.map( Slider, "slider" ).toProvider( provider );
			context.injector.map( Position );
			context.injector.injectInto( this );
			assertThat( instanceOf( HorizontalSliderImpl ), slider );
		}
	}
}
