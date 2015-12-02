/*
 * Copyright (c) 2012 Tobias Goeschel.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package org.robotrunk.ui.text {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	import org.hamcrest.assertThat;

	public class TypeCastPerformanceTest {

		private var _objects:Dictionary;

		[Before]
		public function setUp():void {
			_objects = new Dictionary();
			for( var i:int = 0; i<1000000; i++ ) {
				createClip( i );
			}
		}

		private function createClip( i:int ):void {
			var clip:MovieClip = new MovieClip();
			clip.name = "clip"+i;
			_objects[clip] = true;
		}

		[Test]
		public function theAsOperatorShouldTakeLongerThanTheIsOperator():void {
			var time:int = getTimer();

			for( var clip:* in _objects ) {
				_objects[clip] = clip as Sprite ? true : false;
			}
			var asTime:int = getTimer()-time;

			time = getTimer();

			for( clip in _objects ) {
				_objects[clip] = clip is Sprite;
			}
			var isTime:int = getTimer()-time;

			assertThat( asTime>isTime );
		}

		[After]
		public function tearDown():void {
		}
	}
}