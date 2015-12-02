package org.robotrunk.ui.core {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.data.comparison.equals;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.swiftsuspenders.Injector;

	public class CreationParametersTest {
		private var parameters:CreationParameters;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Before]
		public function setUp():void {
		}

		[Test]
		public function parsesInjectionParametersDictionary():void {
			var par:Dictionary = testValueDictionary();
			var styleMap:StyleMap = mockStyleMap();

			parameters = new CreationParameters( injector, par );

			assertEquals( injector, parameters.injector );
			assertEquals( par.name, parameters.id );
			assertEquals( par.style, parameters.clazz );
			assertEquals( par.kind, parameters.type );
			assertEquals( styleMap, parameters.styleMap );
			assertTrue( parameters.optional );
			assertEquals( "default", parameters.states[0] );
			assertEquals( "over", parameters.states[1] );
		}

		private function mockStyleMap():StyleMap {
			var styleMap:StyleMap = new StyleMap();
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			return styleMap;
		}

		private function testValueDictionary():Dictionary {
			var par:Dictionary = new Dictionary();
			par.name = "testID";
			par.style = "testClazz";
			par.kind = "testType";
			par.map = "testMap";
			par.states = "default,over";
			par.optional = true;
			return par;
		}

		[Test]
		public function outputsParametersToDictionary():void {
			var par:Dictionary = testValueDictionary();
			parameters = new CreationParameters( injector, par );
			var comp:Dictionary = parameters.asDictionary();
			assertTrue( equals( par, comp ) );
		}

		[After]
		public function tearDown():void {
			parameters = null;
			injector = null;
			rule = null;
		}
	}
}
