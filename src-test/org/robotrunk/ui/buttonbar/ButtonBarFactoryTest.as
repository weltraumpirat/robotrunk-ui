package org.robotrunk.ui.buttonbar {
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.buttonbar.api.ButtonBar;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarMode;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarOrientation;
	import org.robotrunk.ui.buttonbar.factory.ButtonBarFactory;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutCenter;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutDown;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutLeft;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutRight;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutUp;
	import org.robotrunk.ui.buttonbar.impl.PaletteButtonBarImpl;
	import org.robotrunk.ui.buttonbar.impl.RelayButtonBarImpl;
	import org.robotrunk.ui.buttonbar.impl.SwitchButtonBarImpl;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.swiftsuspenders.Injector;

	public class ButtonBarFactoryTest {
		private var factory:ButtonBarFactory;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var injector:Injector;

		[Mock]
		public var styleMap:StyleMap;

		private var style:Style;

		[Before]
		public function setUp():void {
			factory = new ButtonBarFactory();
		}

		[Test]
		public function createsPaletteButtonBarIfModeIsNotSet():void {
			mock( injector ).method( "getInstance" ).args( PaletteButtonBarImpl ).returns( new PaletteButtonBarImpl() );
			var bar:UIComponent = createBarWithMode( null );
			assertThat( instanceOf( PaletteButtonBarImpl ), bar );
		}

		[Test]
		public function createsSwitchButtonBarIfModeIsSwitch():void {
			mock( injector ).method( "getInstance" ).args( SwitchButtonBarImpl ).returns( new SwitchButtonBarImpl() );
			var bar:UIComponent = createBarWithMode( ButtonBarMode.SWITCH );
			assertThat( instanceOf( SwitchButtonBarImpl ), bar );
		}

		[Test]
		public function createsRelayButtonBarIfModeIsRelay():void {
			mock( injector ).method( "getInstance" ).args( RelayButtonBarImpl ).returns( new RelayButtonBarImpl() );
			var bar:UIComponent = createBarWithMode( ButtonBarMode.RELAY );
			assertThat( instanceOf( RelayButtonBarImpl ), bar );
		}

		private function createBarWithMode( mode:String ):UIComponent {
			var params:Dictionary = prepareParameters();
			style = new Style();
			if( mode ) {
				style.mode = mode;
			}
			mockStyleMap();
			return factory.create( injector, params );
		}

		[Test]
		public function createsLeftLayoutIfOrientationIsNotSetOrUnknown():void {
			var bar:UIComponent = createBarWithLayout( null );
			assertThat( instanceOf( ButtonBarLayoutLeft ), (bar as ButtonBar).layout );
		}

		[Test]
		public function createsRightLayoutIfOrientationIsRight():void {
			var bar:UIComponent = createBarWithLayout( ButtonBarOrientation.RIGHT );
			assertThat( instanceOf( ButtonBarLayoutRight ), (bar as ButtonBar).layout );
		}

		[Test]
		public function createsCenterLayoutIfOrientationIsCenter():void {
			var bar:UIComponent = createBarWithLayout( ButtonBarOrientation.CENTER );
			assertThat( instanceOf( ButtonBarLayoutCenter ), (bar as ButtonBar).layout );
		}

		[Test]
		public function createsUpLayoutIfOrientationIsUp():void {
			var bar:UIComponent = createBarWithLayout( ButtonBarOrientation.UP );
			assertThat( instanceOf( ButtonBarLayoutUp ), (bar as ButtonBar).layout );
		}

		[Test]
		public function createsDownLayoutIfOrientationIsDown():void {
			var bar:UIComponent = createBarWithLayout( ButtonBarOrientation.DOWN );
			assertThat( instanceOf( ButtonBarLayoutDown ), (bar as ButtonBar).layout );
		}

		private function createBarWithLayout( orientation:String ):UIComponent {
			var params:Dictionary = prepareParameters();
			style = new Style();
			if( orientation ) {
				style.orientation = orientation;
			}
			mockStyleMap();
			mock( injector ).method( "getInstance" ).args( PaletteButtonBarImpl ).returns( new PaletteButtonBarImpl() );
			return factory.create( injector, params );
		}

		private function mockStyleMap():void {
			mock( styleMap ).method( "getComponentStyleCascaded" ).args( "testType",
																		 "testClazz",
																		 "testID" ).returns( style );
			mock( injector ).method( "getInstance" ).args( StyleMap, "testMap" ).returns( styleMap );
		}

		private function prepareParameters():Dictionary {
			var params:Dictionary = new Dictionary();
			params.name = "testID";
			params.style = "testClazz";
			params.kind = "testType";
			params.map = "testMap";
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
