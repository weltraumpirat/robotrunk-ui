package org.robotrunk.ui.button.factory {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertNull;
	import org.robotrunk.ui.core.StyleMap;
	import org.swiftsuspenders.Injector;

	public class AbstractButtonFactoryTest {
		private var factory:AbstractButtonFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		[Before]
		public function setUp():void {
			factory = new AbstractButtonFactory();
		}

		[Test(expects="org.robotrunk.common.error.AbstractMethodInvocationException")]
		public function failsIfInvokedWithoutOverride():void {
			var params:Dictionary = prepareParameters();
			mock( styleMap );
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );

			assertNull( factory.create( injector, params ) );
		}

		[Test]
		public function doesNotFailIfInjectionIsOptional():void {
			var params:Dictionary = prepareParameters();
			params.optional = true;
			mock( styleMap );
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			assertNull( factory.create( injector, params ) );
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
