package org.robotrunk.ui.form.factory {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.form.impl.DropDownListImpl;
	import org.swiftsuspenders.Injector;

	public class DropDownListFactoryTest {
		private var factory:DropDownListFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		[Before]
		public function setUp():void {
			factory = new DropDownListFactory();
		}

		[Test]
		public function createsDropDownList():void {
			var params:Dictionary = prepareParameters();
			mockStyleMap();
			mockInjections();
			var list:DropDownListImpl = factory.create( injector, params ) as DropDownListImpl;
			assertThat( list.elementFactory, instanceOf( DropDownListElementFactory ) );
			assertThat( list.params, instanceOf( CreationParameters ) );
		}

		private function mockInjections():void {
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			mock( injector ).method( "getInstance" ).args( DropDownListImpl ).returns( new DropDownListImpl() );
		}

		private function mockStyleMap():void {
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType", "testClazz",
																		 "testID" ).returns( new Style() );
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
