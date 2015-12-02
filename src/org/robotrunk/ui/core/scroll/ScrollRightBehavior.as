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

package org.robotrunk.ui.core.scroll {
	import flash.display.Sprite;

	import org.robotrunk.ui.button.api.Button;
	import org.robotrunk.ui.core.api.ScrollBehavior;

	public class ScrollRightBehavior extends AbstractVerticalScrollBehavior implements ScrollBehavior {
		override protected function allowsScrolling():Boolean {
			var minX:Number = -_max;
			return _target.x>minX;
		}

		override protected function calculateSpeed():Number {
			return -buttonClip.mouseX;
		}

		override protected function calculateTargetPosition( speed:Number ):Number {
			var minX:Number = -_max;
			var nextX:Number = _target.x+speed;
			return nextX>minX ? nextX : minX;
		}

		public function ScrollRightBehavior( target:Sprite, button:Button ) {
			super( target, button );
		}
	}
}