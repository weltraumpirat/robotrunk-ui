package org.robotrunk.ui.text {
	import org.flexunit.asserts.assertEquals;
	import org.robotrunk.ui.text.textfield.classic.ContentReducer;
	import org.robotrunk.ui.text.textfield.classic.TextChunk;

	public class ContentReducerTest {
		private var reducer:ContentReducer;

		[Before]
		public function setUp():void {
			reducer = new ContentReducer();
		}

		private function assertChunkTextAndClass( chunk:TextChunk, text:String, clazz:String ):void {
			assertEquals( text, chunk.text );
			assertEquals( clazz, chunk.clazz );
		}

		[Test]
		public function whenPassingNull_shouldReturnEmptyArray():void {
			assertEquals( 0, reducer.reduce( null ).length );
		}

		[Test]
		public function whenPassingAnEmptyArray_shouldReturnEmptyArray():void {
			assertEquals( 0, reducer.reduce( [] ).length );
		}

		[Test]
		public function whenPassingASingleTextChunk_shouldReturnSingleTextChunkWithSameValues():void {
			var result:Array = reducer.reduce( [new TextChunk( "something", ".someclass" )] );
			assertEquals( 1, result.length );
			assertChunkTextAndClass( result[0], "something", ".someclass" );
		}

		[Test]
		public function whenPassingTwoChunksWithDifferentClasses_shouldReturnTwoChunksWithSameValues():void {
			var result:Array = reducer.reduce( [new TextChunk( "something", ".someclass" ),
												new TextChunk( "something else", ".someotherclass" )] );
			assertEquals( 2, result.length );
			assertChunkTextAndClass( result[0], "something", ".someclass" );
			assertChunkTextAndClass( result[1], "something else", ".someotherclass" );
		}

		[Test]
		public function whenPassingTwoChunksWithSameClass_shouldReturnSingleChunkWithCombinedText():void {
			var result:Array = reducer.reduce( [new TextChunk( "something", ".someclass" ),
												new TextChunk( " more", ".someclass" )] );
			assertEquals( 1, result.length );
			assertChunkTextAndClass( result[0], "something more", ".someclass" );
		}

		[Test]
		public function whenPassingThreeChunksWithoutPairOfSameClass_shouldReturnThreeChunksWithSameValues():void {
			var result:Array = reducer.reduce( [new TextChunk( "something", ".someclass" ),
												new TextChunk( "something else", ".someotherclass" ),
												new TextChunk( "something else entirely", ".somethirdclass" )] );
			assertEquals( 3, result.length );
			assertChunkTextAndClass( result[0], "something", ".someclass" );
			assertChunkTextAndClass( result[1], "something else", ".someotherclass" );
			assertChunkTextAndClass( result[2], "something else entirely", ".somethirdclass" );
		}

		[Test]
		public function whenPassingThreeChunksWithPairOfSameClass_shouldReturnTwoChunksWithCombinedPairValues():void {
			var result:Array = reducer.reduce( [new TextChunk( "something", ".someclass" ),
												new TextChunk( " more", ".someclass" ),
												new TextChunk( "something else entirely", ".somethirdclass" )] );
			assertEquals( 2, result.length );
			assertChunkTextAndClass( result[0], "something more", ".someclass" );
			assertChunkTextAndClass( result[1], "something else entirely", ".somethirdclass" );

			result = reducer.reduce( [new TextChunk( "something else entirely", ".somethirdclass" ),
									  new TextChunk( "something", ".someclass" ),
									  new TextChunk( " more", ".someclass" )
									 ] );
			assertEquals( 2, result.length );
			assertChunkTextAndClass( result[0], "something else entirely", ".somethirdclass" );
			assertChunkTextAndClass( result[1], "something more", ".someclass" );
		}

		[Test]
		public function whenPassingThreeChunksOfSameClass_shouldReturnSingleChunkWithCombinedValues():void {
			var result:Array = reducer.reduce( [new TextChunk( "something", ".someclass" ),
												new TextChunk( " else", ".someclass" ),
												new TextChunk( " entirely", ".someclass" )] );
			assertEquals( 1, result.length );
			assertChunkTextAndClass( result[0], "something else entirely", ".someclass" );
		}

		[After]
		public function tearDown():void {
			reducer = null;
		}
	}
}