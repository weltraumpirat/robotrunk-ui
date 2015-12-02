package org.robotrunk.ui.button.factory {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.button.impl.SimpleButtonImpl;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.swiftsuspenders.Injector;

	public class SimpleButtonFactoryTest {
		private var factory:SimpleButtonFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		[Before]
		public function setUp():void {
			factory = new SimpleButtonFactory();
		}

		[Test]
		public function createsButton():void {
			var params:Dictionary = prepareParameters();

			mockStyleMap();
			mockInjections();

			assertThat( factory.create( injector, params ), instanceOf( SimpleButtonImpl ) );
		}

		private function mockInjections():void {
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			mock( injector ).method( "getInstance" ).args( SimpleButtonImpl ).returns( new SimpleButtonImpl() );
			mock( injector ).method( "getInstance" ).args( UIViewImpl ).returns( new UIViewImpl() ).twice();
		}

		private function mockStyleMap():void {
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType",
																		 "testClazz",
																		 "testID" ).returns( new Style() );
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType:default",
																		 "testClazz:default",
																		 "testID:default" ).returns( new Style() );
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType:over",
																		 "testClazz:over",
																		 "testID:over" ).returns( new Style() );
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
