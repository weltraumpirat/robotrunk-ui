package org.robotrunk.ui.core {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class StyleTest {
		public var style:Style;

		[Before]
		public function setUp():void {
			style = new Style();
		}

		[Test]
		public function setsAndGetsProperties():void {
			style.something = "something";
			assertEquals( "something", style.something );
		}

		[Test]
		public function addsNewPropertiesOnlyIfTheyDontAlreadyExist():void {
			style.something = "something";
			style.something = "something";
			assertEquals( 1, style.size );
		}

		[Test]
		public function deletesProperties():void {
			style.something = "something";
			assertTrue( delete style.something );
		}

		[Test]
		public function checksForPropertyExistence():void {
			style.something = "something";
			assertTrue( "something" in style );
		}

		[Test]
		public function loopsThroughPropertyNames():void {
			setUpForMultipleEntries();

			var keys:Array = [];
			var ind:int = -1;
			for( var key:String in style ) {
				keys[++ind] = key;
			}

			verifyMultipleKeys( ind, keys );
		}

		private function verifyMultipleKeys( ind:int, keys:Array ):void {
			assertEquals( 2, ind );
			var key1:Boolean, key2:Boolean, key3:Boolean;
			var i:int = -1;
			while( ++i<keys.length ) {
				if( keys[i] == "key1" ) {
					key1 = true;
				}
				if( keys[i] == "key2" ) {
					key2 = true;
				}
				if( keys[i] == "key3" ) {
					key3 = true;
				}
			}
			assertTrue( key1, key2, key3 );
		}

		private function setUpForMultipleEntries():void {
			style.key1 = "something";
			style.key2 = "somethingElse";
			style.key3 = "somethingElseEntirely";
		}

		[Test]
		public function loopsThroughPropertyValues():void {
			setUpForMultipleEntries();
			var values:Array = [];
			var ind:int = -1;
			for each( var value:* in style ) {
				values[++ind] = value;
			}

			verifyMultipleValues( ind, values );
		}

		private function verifyMultipleValues( ind:int, values:Array ):void {
			assertEquals( 2, ind );
			var val1:Boolean, val2:Boolean, val3:Boolean;
			var i:int = -1;
			while( ++i<values.length ) {
				if( values[i] == "something" ) {
					val1 = true;
				}
				if( values[i] == "somethingElse" ) {
					val2 = true;
				}
				if( values[i] == "somethingElseEntirely" ) {
					val3 = true;
				}
			}
			assertTrue( val1, val2, val3 );
		}

		[Test]
		public function returnsNullIfKeyDoesNotExist():void {
			setUpForMultipleEntries();
			assertNull( style.whatever );
		}

		[Test]
		public function resetsEntries():void {
			setUpForMultipleEntries();
			style.reset();
			assertNull( style.something );
		}

		[Test]
		public function destroysInternalsAndReturnsNullIfAnythingIsAccessedAfterwards():void {
			setUpForMultipleEntries();
			style.destroy();
			assertNull( style.something );
		}

		[Test]
		public function outputsPropertiesAsString():void {
			setUpForMultipleEntries();
			style.id = "id";
			style.clazz = "clazz";
			style.type = "type";
			assertEquals( "Style:\nid:id\nclazz:clazz\ntype:type\nkey1:something\nkey2:somethingElse\nkey3:somethingElseEntirely\n",
						  style.toString() );
		}

		[After]
		public function tearDown():void {
			style = null;
		}
	}
}
