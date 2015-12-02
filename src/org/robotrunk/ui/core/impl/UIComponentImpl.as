package org.robotrunk.ui.core.impl {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.event.ViewEvent;

	public class UIComponentImpl extends Sprite implements UIComponent {
		private var _currentState:String = "default";
		private var _position:Position;
		private var _states:Dictionary;
		private var _style:Style;
		private var _left:Number = 0;
		private var _top:Number = 0;
		private var _width:Number = 0;
		private var _height:Number = 0;

		[Inject(optional=true)]
		public var log:Logger;

		public function UIComponentImpl() {
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}

		protected function init():void {
		}

		public function destroy():void {
			destroyStates();

			_top = 0;
			_width = 0;
			_height = 0;
			log = null;
		}

		private function destroyStates():void {
			for each( var st:DisplayObject in states ) {
				st.removeEventListener( ViewEvent.RENDER, onStateRender );
				st.removeEventListener( ViewEvent.RENDER_COMPLETE, onStateRenderComplete );
				if( contains( st ) ) {
					removeChild( st );
				}
			}

			_currentState = null;
			_states = null;
		}

		protected function onAddedToStage( event:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			init();
		}

		protected function onRemovedFromStage( event:Event ):void {
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			destroy();
		}

		protected function switchState( state:String ):void {
			try {
				showState( state );
			} catch( e:Error ) {
				if( log ) {
					log.warn( "No state found for: "+state, this );
				}
			}
		}

		protected function showState( state:String ):void {
			showView( _states[state] );
		}

		protected function showView( view:UIView ):void {
			if( !contains( view as DisplayObject ) ) {
				view.visible = false;
				view.addEventListener( ViewEvent.RENDER, onStateRender );
				view.addEventListener( ViewEvent.RENDER_COMPLETE, onStateRenderComplete );
				addChild( view as DisplayObject );
			}
			else if( view.rendered ) {
				refreshStates();
			}
		}

		protected function onStateRender( ev:Event ):void {
			ev.stopPropagation();
			ev.target.removeEventListener( ViewEvent.RENDER, onStateRender );
			dispatchEvent( new ViewEvent( ViewEvent.RENDER ) );
		}

		protected function onStateRenderComplete( ev:Event ):void {
			ev.stopPropagation();
			ev.target.removeEventListener( ViewEvent.RENDER_COMPLETE, onStateRenderComplete );
			refreshStates();
			update();
			dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
		}

		protected function update():void {
			updateWidth();
			updateHeight();
			positionComponent();
		}

		protected function positionComponent():void {
			if( _position && (style.top || style.bottom || style.right || style.left) ) {
				_position.forTarget( this ).
						withCoordinates( calculateXCoordinate(), calculateYCoordinate() ).
						apply();
			}
		}

		private function calculateYCoordinate():Number {
			var top:Number = style.top || 0;
			var bottom:Number = style.bottom || 0;
			return top ? top : bottom ? -bottom : 0;
		}

		private function calculateXCoordinate():Number {
			var left:Number = style.left || 0;
			var right:Number = style.right || 0;
			return left ? left : right ? -right : 0;
		}

		private function updateWidth():void {
			width = 0;
			for each( var st:UIView in states ) {
				width = st.width>width ? st.width : width;
			}
		}

		private function updateHeight():void {
			height = 0;
			for each( var st:UIView in states ) {
				height = st.height>height ? st.height : height;
			}
		}

		protected function refreshStates():void {
			for( var state:String in _states ) {
				var view:UIView = _states[state];
				if( view ) {
					refreshView( view );
				}
			}
		}

		private function refreshView( view:UIView ):void {
			if( view.rendered ) {
				view.visible = currentState == view.state;
			} else {
				view.visible = false;
			}
		}

		public function get currentState():String {
			return _currentState;
		}

		public function set currentState( state:String ):void {
			_currentState = state;
			switchState( state );
		}

		public function get states():Dictionary {
			return _states;
		}

		public function set states( states:Dictionary ):void {
			_states = states;
		}

		override public function get width():Number {
			return _width;
		}

		override public function set width( width:Number ):void {
			_width = width;
		}

		override public function get height():Number {
			return _height;
		}

		override public function set height( height:Number ):void {
			_height = height;
		}

		public function get left():Number {
			return _left;
		}

		public function set left( left:Number ):void {
			_left = left;
		}

		public function get top():Number {
			return _top;
		}

		public function set top( top:Number ):void {
			_top = top;
		}

		public function get style():Style {
			return _style;
		}

		public function set style( style:Style ):void {
			_style = style;
		}

		public function get position():Position {
			return _position;
		}

		[Inject]
		public function set position( position:Position ):void {
			_position = position;
		}

		public function applyToStyles( property:String, value:* ):void {
			style[property] = value;
			for each( var view:UIView in states ) {
				view.style[property] = value;
				if( view.content != null && view.content["style"] != null ) {
					view.content["style"][property] = value;
				}
				if( stage != null ) {
					view.render();
				}
			}
		}
	}
}
