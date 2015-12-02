package org.robotrunk.ui.core {
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.data.comparison.equals;

	public class StyleMapTest {
		private var styleMap:StyleMap;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var styleSheet:StyleSheet;

		private var testStyle:Object;

		private var testFormat:TextFormat;

		[Before]
		public function setUp():void {
			testStyle = {fontFamily: "SomeFont", fontSize: "12px"};
			testFormat = new TextFormat( "SomeFont", 12 );
			styleMap = new StyleMap();
		}

		[Test]
		public function canCopyStyles():void {
			var from:StyleSheet = new StyleSheet();
			from.setStyle( "something", testStyle );
			var to:StyleSheet = new StyleSheet();

			StyleMap.copyStyles( from, to );

			assertEquals( "something", to.styleNames[0] );

			var format:Object = to.getStyle( "something" );
			assertEquals( "SomeFont", format.fontFamily );
			assertEquals( "12px", format.fontSize );
		}

		[Test]
		public function returnsStyleByName():void {
			mock( styleSheet ).method( "getStyle" ).args( "something" ).returns( testStyle );
			styleMap.styleSheet = styleSheet;
			assertEquals( testStyle, styleMap.getStyleByName( "something" ) );
			assertNull( styleMap.getStyleByName( "somethingElse" ) );
		}

		[Test]
		public function returnsStyleAsTextFormat():void {
			mock( styleSheet ).method( "getStyle" ).args( "something" ).returns( testStyle );
			mock( styleSheet ).method( "transform" ).args( testStyle ).returns( testFormat );
			styleMap.styleSheet = styleSheet;
			assertEquals( testFormat, styleMap.getStyleAsTextFormatOrNull( "something" ) );
			assertNull( styleMap.getStyleAsTextFormatOrNull( "somethingElse" ) );
		}

		[Test]
		public function returnsCascadingStyle():void {
			mock( styleSheet ).method( "getStyle" ).args( "type" ).returns( {fontFamily   : "Arial",
																				fontSize  : "10px",
																				fontWeight: "normal"
																			} );
			mock( styleSheet ).method( "getStyle" ).args( ".class" ).returns( {fontFamily   : "Verdana",
																				  fontWeight: "bold"
																			  } );
			mock( styleSheet ).method( "getStyle" ).args( "#id" ).returns( {fontFamily: "Arial", fontSize: "12px"} );

			styleMap.styleSheet = styleSheet;
			assertTrue( equals( {fontFamily   : "Arial",
									fontSize  : "12px",
									fontWeight: "bold"
								},
								styleMap.getStyleCascaded( "type", "class", "id" ) ) );
		}

		[Test]
		public function returnsCascadingStyleWithTransformedNumericAndBooleanValues():void {
			mock( styleSheet ).method( "getStyle" ).args( "type" ).returns( {fontFamily          : "Arial",
																				fontSize         : "10px",
																				fontWeight       : "normal",
																				displayAsPassword: "true",
																				color            : "#ff0000",
																				alpha            : "0.1"
																			} );
			mock( styleSheet ).method( "getStyle" ).args( ".class" ).returns( {fontFamily   : "Verdana",
																				  fontWeight: "bold"
																			  } );
			mock( styleSheet ).method( "getStyle" ).args( "#id" ).returns( {fontFamily: "Arial", fontSize: "12px"} );

			styleMap.styleSheet = styleSheet;
			assertTrue( equals( {fontFamily          : "Arial",
									fontSize         : 12,
									fontWeight       : "bold",
									displayAsPassword: true,
									color            : 0xFF0000,
									alpha            : 0.1
								},
								styleMap.getComponentStyleCascaded( "type", "class", "id" ) ) );
		}

		[Test]
		public function outputsCssString():void {
			mock( styleSheet ).getter( "styleNames" ).returns( ["something"] );
			mock( styleSheet ).method( "getStyle" ).args( "something" ).returns( testStyle );
			styleMap.styleSheet = styleSheet;
			assertEquals( "something{fontFamily:SomeFont;fontSize:12px;}\n", styleMap.toCssString() );
		}

		[Test]
		public function outputsEmptyCssStringIfNoStyles():void {
			mock( styleSheet ).getter( "styleNames" ).returns( [] );
			styleMap.styleSheet = styleSheet;
			assertEquals( "", styleMap.toCssString() );
		}

		[Test]
		public function cleansUpNicely():void {
			styleMap.styleSheet = styleSheet;
			styleMap.destroy();
			assertNull( styleMap.styleSheet );
		}

		[After]
		public function tearDown():void {
			styleMap = null;
			testFormat = null;
			testStyle = null;
		}
	}
}
