package org.robotrunk.ui.slider.factory {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.slider.impl.HorizontalSliderImpl;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;
	import org.swiftsuspenders.Injector;

	public class HorizontalSliderFactoryTest {
		private var factory:HorizontalSliderFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		[Mock]
		public var buttonFactory:SliderButtonFactory;

		[Before]
		public function setUp():void {
			factory = new HorizontalSliderFactory();
		}

		[Test]
		public function createsSlider():void {
			var params:Dictionary = prepareParameters();
			mockStyleMap();
			mockDependencies();
			mockButtonFactory();
			assertThat( factory.create( injector, params ), instanceOf( HorizontalSliderImpl ) );
		}

		private function mockButtonFactory():void {
			mock( buttonFactory ).method( "create" ).args( injector,
														   instanceOf( Dictionary ) ).returns( new SliderButtonImpl() );
			factory.buttonFactory = buttonFactory;
		}

		private function mockDependencies():void {
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			mock( injector ).method( "getInstance" ).args( HorizontalSliderImpl ).returns( new HorizontalSliderImpl() );
			mock( injector ).method( "getInstance" ).args( UIViewImpl ).returns( new UIViewImpl() ).twice();
		}

		private function mockStyleMap():void {
			var style:Style = new Style();
			style.icon = "something";
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType",
																		 "testClazz",
																		 "testID" ).returns( style );
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType:default",
																		 "testClazz:default",
																		 "testID:default" ).returns( style );
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType:over",
																		 "testClazz:over",
																		 "testID:over" ).returns( style );
		}

		private function prepareParameters():Dictionary {
			var params:Dictionary = new Dictionary();
			params.name = "testID";
			params.style = "testClazz";
			params.kind = "testType";
			params.map = "testMap";
			params.states = "default,over";
			params.optional = false;

			return params;
		}

		[After]
		public function tearDown():void {
			factory = null;
			styleMap = null;
			rule = null;
			injector = null;
		}
	}
}
