/*
 * Copyright (c) 2013 Tobias Goeschel.
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

package org.robotrunk.ui.core.util {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.robotools.graphics.drawing.GraphRectangle;

	public class StageDisabler extends Disabler {
		public function StageDisabler( target:DisplayObject ) {
			super( target );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage )
		}

		private function onAddedToStage( event:Event ):void {
			render();
			stage.addEventListener( Event.RESIZE, onStageResize, false, 0, true );
		}

		private function onStageResize( event:Event ):void {
			render();
		}

		override public function render():void {
			graphics.clear();
			var wid:Number = stage != null ? stage.stageWidth : _target.width;
			var hei:Number = stage != null ? stage.stageHeight : _target.height;
			new GraphRectangle( this ).createRectangle( new Rectangle( 0, 0, wid, hei ) ).noLine().fill( 0, .1 ).draw();
			if( _target.parent != null ) {
				_target.parent.addChildAt( this, nextHighestIndex );
				var pt:Point = _target.parent.globalToLocal( new Point( 0, 0 ) );
				x = pt.x;
				y = pt.y;
			}
		}

		override public function destroy():void {
			if( stage != null ) {
				stage.removeEventListener( Event.RESIZE, onStageResize );
			}
			super.destroy();
		}
	}
}
