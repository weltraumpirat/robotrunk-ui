package org.robotrunk.ui.button.factory {
	import flash.display.MovieClip;
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.button.impl.TextButtonImpl;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.content.TextImageContent;
	import org.robotrunk.ui.text.factory.textfield.TLFTextFieldFactory;
	import org.swiftsuspenders.Injector;

	public class TextButtonFactoryTest {
		private var factory:TextButtonFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		[Before]
		public function setUp():void {
			factory = new TextButtonFactory( new TLFTextFieldFactory() );
		}

		[Test]
		public function createsButton():void {
			var params:Dictionary = prepareParameters();
			mockStyleMap();
			mockDependencies();
			assertThat( factory.create( injector, params ), instanceOf( TextButtonImpl ) );
		}

		private function mockDependencies():void {
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
			mock( injector ).method( "getInstance" ).args( TextButtonImpl ).returns( new TextButtonImpl() );
			mock( injector ).method( "getInstance" ).args( UIViewImpl ).returns( new UIViewImpl() ).twice();
			mock( injector ).method( "getInstance" ).args( TextImageContent ).returns( new TextImageContent() );
			mock( injector ).method( "getInstance" ).args( MovieClip, "something" ).returns( new MovieClip() );
			mock( injector ).method( "getInstance" ).args( MovieClipHelper ).returns( new MovieClipHelper() );
		}

		private function mockStyleMap():void {
			var style:Style = new Style();
			style.icon = "something";
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType", "testClazz",
																		 "testID" ).returns( style );
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType:default", "testClazz:default",
																		 "testID:default" ).returns( style );
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType:over", "testClazz:over",
																		 "testID:over" ).returns( style );
			mock( styleMap ).getter( "styleSheet" ).returns( new StyleSheet() );
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
