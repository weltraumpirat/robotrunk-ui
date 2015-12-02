package org.robotrunk.ui.core.impl {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	import org.robotools.graphics.removeAll;
	import org.robotrunk.common.error.MissingValueException;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.AutoSizer;
	import org.robotrunk.ui.core.api.Background;
	import org.robotrunk.ui.core.api.Shadow;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.event.ViewEvent;

	public class UIViewImpl extends Sprite implements UIView {
		private var _autoSizer:AutoSizer;
		private var _background:Background;
		private var _content:Sprite = new Sprite();
		private var _shadow:Shadow;
		private var _style:Style;
		private var _state:String;
		private var _height:Number;
		private var _width:Number;
		private var _rendered:Boolean;

		[Inject]
		public var position:Position;

		public function render():void {
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
			doRender();
		}

		private function doRender():void {
			if( background ) {
				renderBackground();
			}
			if( content ) {
				renderContent();
			}
			if( shadow ) {
				renderShadow();
			}
		}

		private function processAutoSize():void {
			if( autoSizer ) {
				applyAutoSizerAndRepeatIfNecessary();
			} else {
				finishRendering();
			}
		}

		private function applyAutoSizerAndRepeatIfNecessary():void {
			autoSizer.prepare( content, style );
			if( autoSizer.needsAutoSize ) {
				autoSizer.resize();
				doRender();
			} else {
				finishRendering();
			}
			if( autoSizer )      // may change after resize
			{
				autoSizer.reset();
			}
		}

		private function finishRendering():void {
			if( content ) {
				content.removeEventListener( ViewEvent.RENDER_COMPLETE, onContentRenderComplete );
				_rendered = true;
				if( position ) {
					position.forTarget( content ).within( style ).withPadding().apply();
				}
				dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
			}
		}

		public function destroy():void {
			removeAll( this );

			clearShadow();
			clearBackground();
			clearStyle();
			clearPosition();
			_autoSizer = null;
			_content = null;
			_state = null;
			_height = 0;
			_width = 0;
		}

		private function clearShadow():void {
			if( _shadow ) {
				_shadow.clear();
			}
			_shadow = null;
		}

		private function clearBackground():void {
			if( _background ) {
				_background.destroy();
			}
			_background = null;
		}

		private function clearStyle():void {
			if( _style ) {
				_style.destroy();
			}
			_style = null;
		}

		private function clearPosition():void {
			if( position ) {
				position.destroy();
			}
			position = null;
		}

		protected function renderContent():void {
			content.addEventListener( ViewEvent.RENDER_COMPLETE, onContentRenderComplete );
			addChild( content );
			content["render"]();
		}

		private function onContentRenderComplete( ev:ViewEvent ):void {
			processAutoSize();
		}

		protected function renderBackground():void {
			background.draw( style );
			var bg:DisplayObject = background as DisplayObject;
			addChildAt( bg, 0 );
		}

		protected function renderShadow():void {
			shadow.create();
		}

		public function UIViewImpl( state:String = null ):void {
			_state = state;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}

		protected function init():void {
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			if( isValid() ) {
				render();
			}
		}

		protected function isValid():Boolean {
			if( !style ) {
				throw new MissingValueException( "You must provide a Style for each view." );
			}

			if( !position ) {
				throw new MissingValueException( "You must provide a Position for each view." );
			}
			return true;
		}

		private function onAddedToStage( ev:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			init();
		}

		private function onRemovedFromStage( ev:Event ):void {
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			destroy();
		}

		override public function get height():Number {
			return !isNaN( _height ) ? _height :
				   _background && _background.height>_content.height ? _background.height :
				   _content.height>super.height ? _content.height : super.height;
		}

		override public function set height( height:Number ):void {
			_height = height;
		}

		override public function get width():Number {
			return !isNaN( _width ) ? _width :
				   _background && _background.width>_content.width ? _background.width :
				   _content.width>super.width ? _content.width : super.width;
		}

		override public function set width( width:Number ):void {
			_width = width;
		}

		public function get state():String {
			return _state;
		}

		public function set state( state:String ):void {
			_state = state;
		}

		public function get style():Style {
			return _style;
		}

		public function set style( style:Style ):void {
			_style = style;
		}

		public function get background():Background {
			return _background;
		}

		public function set background( background:Background ):void {
			_background = background;
		}

		public function get content():Sprite {
			return _content;
		}

		public function set content( content:Sprite ):void {
			_content = content;
		}

		public function get shadow():Shadow {
			return _shadow;
		}

		public function set shadow( shadow:Shadow ):void {
			_shadow = shadow;
		}

		public function get autoSizer():AutoSizer {
			return _autoSizer;
		}

		public function set autoSizer( autoSizer:AutoSizer ):void {
			_autoSizer = autoSizer;
		}

		public function get rendered():Boolean {
			return _rendered;
		}
	}
}
