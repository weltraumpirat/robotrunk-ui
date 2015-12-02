package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;
	import flash.events.Event;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.button.event.ButtonEvent;
	import org.robotrunk.ui.buttonbar.api.ButtonBar;
	import org.robotrunk.ui.buttonbar.api.ButtonBarLayout;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarMode;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarOrientation;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.UIComponentImpl;

	[Event(name="RENDER", type="org.robotrunk.ui.core.event.ViewEvent")]
	[Event(name="RENDER_COMPLETE", type="org.robotrunk.ui.core.event.ViewEvent")]
	public class AbstractButtonBarImpl extends UIComponentImpl implements ButtonBar {
		protected var _buttons:Vector.<DisplayObject>;

		private var _mode:String = ButtonBarMode.SWITCH;

		private var _offset:int = 0;

		private var _orientation:String = ButtonBarOrientation.LEFT;

		private var _ready:int = 0;

		private var _render:int = 0;

		private var _layout:ButtonBarLayout;

		override public function destroy():void {
			for each( var btn:DisplayObject in _buttons ) {
				destroyButton( btn );
			}

			while( numChildren>0 ) {
				removeChildAt( 0 );
			}

			_buttons = null;
			_mode = null;
			_orientation = null;
			_layout = null;

			super.destroy();
		}

		private function destroyButton( button:DisplayObject ):void {
			button.removeEventListener( ViewEvent.RENDER_COMPLETE, onButtonRenderComplete );
			button.removeEventListener( ViewEvent.RENDER, onButtonRender );
			button.removeEventListener( ButtonEvent.BUTTON_CLICK, onButtonClick );
			removeChild( button );
		}

		override protected function init():void {
		}

		public function render():void {
			positionButtons();
			positionComponent();
			visible = true;
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		private function positionButtons():void {
			layout.position( buttons, style.offset>0 ? style.offset : offset );
		}

		protected function onButtonClick( ev:Event ):void {
			throw new AbstractMethodInvocationException( "You must override the 'onButtonClick' event handler." );
		}

		public function AbstractButtonBarImpl() {
			visible = false;
			super();
		}

		public function get buttons():Vector.<DisplayObject> {
			return _buttons;
		}

		public function set buttons( buttons:Vector.<DisplayObject> ):void {
			_buttons = buttons;
			_ready = 0;
			_render = 0;
			if( buttons ) {
				for each( var button:DisplayObject in buttons ) {
					addButton( button );
				}
			}
		}

		private function addButton( button:DisplayObject ):void {
			button.addEventListener( ViewEvent.RENDER_COMPLETE, onButtonRenderComplete );
			button.addEventListener( ViewEvent.RENDER, onButtonRender );
			button.addEventListener( ButtonEvent.BUTTON_CLICK, onButtonClick );
			addChild( button );
		}

		private function onButtonRender( ev:ViewEvent ):void {
			if( ++_render>=1 ) {
				dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			}
		}

		private function onButtonRenderComplete( ev:ViewEvent ):void {
			if( ++_ready>=buttons.length ) {
				render();
			}
		}

		public override function get height():Number {
			return _buttons ? totalHeight : 0;
		}

		private function get totalHeight():Number {
			var total:Number = 0;
			_buttons.forEach( function ( button:DisplayObject, i:int, self:Vector.<DisplayObject> ):void {
				total = isHorizontal ? (button.height>total ? button.height : total) :
						(i>0 ? total+button.height+_offset : total+button.height);
			} );
			return total;
		}

		private function get isHorizontal():Boolean {
			return orientation == ButtonBarOrientation.LEFT || orientation == ButtonBarOrientation.RIGHT || orientation == ButtonBarOrientation.CENTER;
		}

		public override function get width():Number {
			return _buttons ? totalWidth : 0;
		}

		private function get totalWidth():Number {
			var total:Number = 0;
			_buttons.forEach( function ( button:DisplayObject, i:int, self:Vector.<DisplayObject> ):void {
				total = isVertical ? (button.width>total ? button.width : total) :
						(i>0 ? total+button.width+_offset : total+button.width);
			} );
			return total;
		}

		private function get isVertical():Boolean {
			return orientation == ButtonBarOrientation.DOWN || orientation == ButtonBarOrientation.UP;
		}

		public function get mode():String {
			return _mode;
		}

		public function set mode( mode:String ):void {
			_mode = mode;
		}

		public function get offset():int {
			return _offset;
		}

		public function set offset( offset:int ):void {
			_offset = offset;
		}

		public function get orientation():String {
			return _orientation;
		}

		public function set orientation( orientation:String ):void {
			_orientation = orientation;
		}

		public function get layout():ButtonBarLayout {
			return _layout;
		}

		public function set layout( layout:ButtonBarLayout ):void {
			_layout = layout;
		}
	}
}
