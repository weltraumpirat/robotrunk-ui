package org.robotrunk.ui.core {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIComponentFactory;
	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.core.impl.UIComponentImpl;
	import org.swiftsuspenders.Injector;

	public class UIComponentProviderTest {
		private var provider:UIComponentProvider;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var factory:UIComponentFactory;

		[Before]
		public function setUp():void {
		}

		[Test]
		public function providesComponent():void {
			var comp:UIComponent = new UIComponentImpl();
			var injector:Injector = new Injector();
			var params:Dictionary = new Dictionary();
			mock( factory ).method( "create" ).args( injector, params ).returns( comp );
			provider = new UIComponentProvider( factory );
			provider.apply( null, injector, params );
		}

		[After]
		public function tearDown():void {
			provider = null;
			rule = null;
			factory = null;
		}
	}
}
