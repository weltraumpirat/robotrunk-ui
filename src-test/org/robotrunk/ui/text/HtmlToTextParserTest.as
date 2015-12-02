package org.robotrunk.ui.text {
	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.text.textfield.classic.ContentReducer;
	import org.robotrunk.ui.text.textfield.classic.HtmlToTextParser;
	import org.robotrunk.ui.text.textfield.classic.TextChunk;

	public class HtmlToTextParserTest {
		private var parser:HtmlToTextParser;
		[Rule]
		public var rule:MockolateRule = new MockolateRule();
		[Mock]
		public var reducer:ContentReducer;

		private var mockResult:Array = ["something"];
		private var simpleTestParagraph:String = "<text><p><span class=\"something\">Something</span></p></text>";
		private var compositeTestParagraph:String = "<text><p><span class=\"something\">Something</span><span class=\"somethingElse\">Something Else</span></p></text>";

		[Before]
		public function setUp():void {
			XML.ignoreWhitespace = true;
			XML.prettyPrinting = false;
			parser = new HtmlToTextParser();
		}

		private function assertChunkTextAndClass( chunk:TextChunk, text:String, clazz:String ):void {
			assertEquals( text, chunk.text );
			assertEquals( clazz, chunk.clazz );
		}

		[Test]
		public function paragraphShouldBeProcessedToTextChunkArray():void {
			var result:Array = parser.parse( simpleTestParagraph );
			assertTrue( result is Array );
			assertEquals( 1, result.length );
			assertChunkTextAndClass( result[0], "Something\n", ".something" );
		}

		[Test]
		public function twoSpansShouldBeTwoTextChunks():void {
			var result:Array = parser.parse( compositeTestParagraph );
			assertNotNull( result );
			assertEquals( 2, result.length );
			assertChunkTextAndClass( result[0], "Something", ".something" );
			assertChunkTextAndClass( result[1], "Something Else\n", ".somethingElse" );
		}

		[Test]
		public function lastChunkOfAParagraphShouldHaveANewLineAppended():void {
			var result:Array = parser.parse( compositeTestParagraph );
			var chunk:TextChunk = result[result.length-1];
			assertEquals( "\n", chunk.text.substr( chunk.text.length-1 ) );
		}

		[Test]
		public function parsingTextShouldInvokeContentReduction():void {
			mock( reducer ).method( "reduce" ).args( instanceOf( Array ) ).returns( mockResult ).once();
			parser.reducer = reducer;

			parser.parse( simpleTestParagraph );
		}

		[After]
		public function tearDown():void {
			parser = null;
		}
	}
}