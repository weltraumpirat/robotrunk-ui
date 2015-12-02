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

package org.robotrunk.ui.window.impl {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotrunk.ui.core.api.Content;
	import org.robotrunk.ui.core.event.ViewEvent;

	public class ScrollablePane extends Sprite implements Content {
		private var _content:Sprite;
		private var _contentMask:Sprite;
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _horizontalPosition:Number = 0;
		private var _verticalPosition:Number = 0;

		override public function get width():Number {
			return _width;
		}

		override public function set width( width:Number ):void {
			_width = width;
			if( contentMask != null ) {
				updateMask();
			}
		}

		override public function get height():Number {
			return _height;
		}

		override public function set height( height:Number ):void {
			_height = height;
			if( contentMask ) {
				updateMask();
			}
		}

		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			contentMask ||= new Sprite();
			updateMask();
			addChild( contentMask );
			_content.mask = contentMask;
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		private function updateMask():void {
			contentMask.graphics.clear();
			new GraphRectangle( contentMask ).createRectangle( new Rectangle( 0, 0, width, height ) ).fill( 0,
																											1 ).draw();
		}

		public function destroy():void {
			while( numChildren>0 ) {
				removeChildAt( 0 );
			}

			if( _content ) {
				destroyContent();
			}

			_content = null;
			_contentMask = null;
		}

		private function destroyContent():void {
			_content.removeEventListener( "UPDATED", onContentUpdated );
			_content.mask = null;
		}

		public function set content( content:Sprite ):void {
			_content = content;
			if( content ) {
				initContent();
			}
		}

		private function initContent():void {
			content.addEventListener( "UPDATED", onContentUpdated, false, 0, true );
			addChild( content );
		}

		private function onContentUpdated( ev:Event ):void {
			if( contentMask ) {
				updateMask();
			}
		}

		public function get content():Sprite {
			return _content;
		}

		public function get horizontalPosition():Number {
			return _horizontalPosition;
		}

		public function set horizontalPosition( horizontalPosition:Number ):void {
			_horizontalPosition = horizontalPosition<0 ? 0 : horizontalPosition>100 ? 100 : horizontalPosition;
			if( content ) {
				content.x = isHorizontallyScrollable ? scrolledContentXPosition : 0;
			}
		}

		private function get scrolledContentXPosition():Number {
			return -_horizontalPosition*( content.width-contentMask.width )*.01;
		}

		private function get isHorizontallyScrollable():Boolean {
			return content.width>contentMask.width;
		}

		public function get verticalPosition():Number {
			return _verticalPosition;
		}

		public function set verticalPosition( verticalPosition:Number ):void {
			_verticalPosition = verticalPosition<0 ? 0 : verticalPosition>100 ? 100 : verticalPosition;
			if( content ) {
				content.y = isVerticallyScrollable ? scrolledContentYPosition : 0;
			}
		}

		private function get isVerticallyScrollable():Boolean {
			return content.height>contentMask.height;
		}

		private function get scrolledContentYPosition():Number {
			return -_verticalPosition*( content.height-contentMask.height)*.01;
		}

		public function get contentMask():Sprite {
			return _contentMask;
		}

		public function set contentMask( value:Sprite ):void {
			_contentMask = value;
		}
	}
}
