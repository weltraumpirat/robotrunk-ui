package org.robotrunk.ui.text.factory {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.content.TextContent;
	import org.robotrunk.ui.text.factory.component.LabelFactory;
	import org.robotrunk.ui.text.factory.textfield.TLFTextFieldFactory;
	import org.robotrunk.ui.text.impl.LabelImpl;
	import org.swiftsuspenders.Injector;

	public class LabelFactoryTest {
		private var factory:LabelFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		[Before]
		public function setUp():void {
			factory = new LabelFactory( new TLFTextFieldFactory() );
		}

		[Test]
		public function createsLabel():void {
			var params:Dictionary = prepareParameters();
			mockStyleMap();
			mockDependencies();
			assertThat( factory.create( injector, params ), instanceOf( LabelImpl ) );
		}

		private function mockDependencies():void {
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			mock( injector ).method( "getInstance" ).args( LabelImpl ).returns( new LabelImpl() );
			mock( injector ).method( "getInstance" ).args( UIViewImpl ).returns( new UIViewImpl() ).twice();
			mock( injector ).method( "getInstance" ).args( TextContent ).returns( new TextContent() );
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
