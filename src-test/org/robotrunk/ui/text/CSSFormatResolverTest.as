package org.robotrunk.ui.text {
	import flash.text.StyleSheet;

	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.ITextLayoutFormat;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;

	public class CSSFormatResolverTest {
		private var resolver:CSSFormatResolver;

		private var pStyle:Object;

		private var clsStyle:Object;

		private var elem:ParagraphElement;

		private var flow:TextFlow;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var styleSheet:StyleSheet;

		[Before]
		public function setUp():void {
			pStyle = {textAlign: "right"};
			clsStyle = {color: 0xFF0000};
			elem = new ParagraphElement();
			elem.styleName = "something";
			flow = new TextFlow();
			flow.addChild( elem );
		}

		[Test]
		public function canResolveFormatForSingleElement():void {
			mockStyles();
			var tlf:ITextLayoutFormat = initializeResolverAndReturnFormat();
			assertNotNull( tlf );
		}

		[Test]
		public function canResolveFormatFromCache():void {
			mockStyles();
			var tlf:ITextLayoutFormat = initializeResolverAndReturnFormat();
			// second call gets format from cache, no additonal call to the styleSheet
			tlf = resolveFormatAndVerify( elem );
		}

		[Test]
		public function canInvalidateCacheForSingleElement():void {
			mockStyles();
			mockStyles();

			var tlf:ITextLayoutFormat = initializeResolverAndReturnFormat();
			// cache invalidated, additional call to styleSheet is made
			resolver.invalidate( elem );
			tlf = resolveFormatAndVerify( elem );
		}

		[Test]
		public function canInvalidateCacheForTextFlow():void {
			mockStyles();
			mockStyles();

			var tlf:ITextLayoutFormat = initializeResolverAndReturnFormat();

			flow.formatResolver = resolver;
			resolver.invalidateAll( flow );

			// cache invalidated, additional call to styleSheet is made
			tlf = resolveFormatAndVerify( elem );
		}

		private function initializeResolverAndReturnFormat():ITextLayoutFormat {
			resolver = new CSSFormatResolver( styleSheet );
			var tlf:ITextLayoutFormat = resolveFormatAndVerify( elem );
			return tlf;
		}

		private function resolveFormatAndVerify( elem:ParagraphElement ):ITextLayoutFormat {
			var tlf:ITextLayoutFormat = null;
			tlf = resolver.resolveFormat( elem );
			verifyStyles( tlf );
			return tlf;
		}

		private function verifyStyles( tlf:ITextLayoutFormat ):void {
			assertEquals( "right", tlf.textAlign );
			assertEquals( 0xFF0000, tlf.color );
		}

		private function mockStyles():void {
			mock( styleSheet ).method( "getStyle" ).args( "p" ).returns( pStyle ).once();
			mock( styleSheet ).method( "getStyle" ).args( ".something" ).returns( clsStyle ).once();
		}

		[After]
		public function tearDown():void {
			resolver = null;
			styleSheet = null;
			pStyle = null;
			clsStyle = null;
			flow.removeChild( elem );
			flow.formatResolver = null;
			flow = null;
			elem = null;
		}
	}
}
