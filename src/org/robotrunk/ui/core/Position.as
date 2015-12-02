package org.robotrunk.ui.core {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	import org.robotools.data.copy.safeGetPropertyOrDefault;
	import org.robotrunk.common.error.MissingValueException;

	public class Position {
		private var _target:DisplayObject;

		private var _container:*;

		private var _align:String;

		private var _vAlign:String;

		private var _coordinates:Point;

		private var _useContainerCoordinates:Boolean = false;

		private var _usePadding:Boolean = false;

		[Inject]
		public var padding:Padding;

		public function destroy():void {
			padding = null;
			_target = null;
			_container = null;
			_align = null;
			_vAlign = null;
			_usePadding = false;
			_coordinates = null;
			_useContainerCoordinates = false;
		}

		public function forTarget( target:DisplayObject ):Position {
			_target = target;
			if( !_container ) {
				_container = target;
			}
			return this;
		}

		public function alignLeft():Position {
			_align = "left";
			return this;
		}

		public function alignRight():Position {
			_align = "right";
			return this;
		}

		public function center():Position {
			_align = "center";
			return this;
		}

		public function atTop():Position {
			_vAlign = "top";
			return this;
		}

		public function atBottom():Position {
			_vAlign = "bottom";
			return this;
		}

		public function atMiddle():Position {
			_vAlign = "middle";
			return this;
		}

		public function within( container:* ):Position {
			_container = container;
			return this;
		}

		public function withPadding():Position {
			_usePadding = true;
			return this;
		}

		public function noPadding():Position {
			_usePadding = false;
			return this;
		}

		public function usingContainerCoordinates():Position {
			_useContainerCoordinates = true;
			return this;
		}

		public function withCoordinates( x:Number, y:Number ):Position {
			_coordinates = new Point( x, y );
			return this;
		}

		public function apply():void {
			if( validate() ) {
				if( !_align ) {
					processTextAlign();
				}
				if( !_vAlign ) {
					processVerticalAlign();
				}
				if( _useContainerCoordinates ) {
					processCoordinates();
				}
				doPosition();
			}
		}

		private function processCoordinates():void {
			var left:Number = safeGetPropertyOrDefault( _container, "left", 0 );
			var top:Number = safeGetPropertyOrDefault( _container, "top", 0 );
			var right:Number = safeGetPropertyOrDefault( _container, "right", 0 );
			var bottom:Number = safeGetPropertyOrDefault( _container, "bottom", 0 );

			withCoordinates( left ? left : right ? -right : 0, top ? top : bottom ? -bottom : 0 );
		}

		private function processTextAlign():void {
			_align = safeGetPropertyOrDefault( _container, "textAlign", "left" );
		}

		private function processVerticalAlign():void {
			_vAlign = safeGetPropertyOrDefault( _container, "verticalAlign", "middle" );
		}

		private function doPosition():void {
			if( _align == "right" ) {
				positionRight();
			} else if( _align == "left" ) {
				positionLeft();
			} else if( _align == "center" ) {
				positionCenter();
			}

			if( _vAlign == "top" ) {
				positionTop();
			} else if( _vAlign == "bottom" ) {
				positionBottom();
			} else if( _vAlign == "middle" ) {
				positionMiddle();
			}
		}

		private function validate():Boolean {
			if( !_target ) {
				throw new MissingValueException( "You must specify a target object." );
			}
			return true;
		}

		private function positionLeft():void {
			_target.x = paddingLeft+displacementX;
		}

		private function positionRight():void {
			_target.x = _container.width-_target.width-paddingRight+displacementX;
		}

		private function positionTop():void {
			_target.y = paddingTop+displacementY;
		}

		private function positionBottom():void {
			_target.y = _container.height-_target.height-paddingBottom+displacementY;
		}

		private function positionCenter():void {
			_target.x = (_container.width-_target.width)*.5+displacementX;
		}

		private function positionMiddle():void {
			_target.y = (_container.height-_target.height)*.5+displacementY;
		}

		private function get displacementX():int {
			return _coordinates ? _coordinates.x : 0;
		}

		private function get displacementY():int {
			return _coordinates ? _coordinates.y : 0;
		}

		private function get paddingLeft():int {
			return _usePadding ? padding.getPaddingLeft( _container ) : 0;
		}

		private function get paddingRight():int {
			return _usePadding ? padding.getPaddingRight( _container ) : 0;
		}

		private function get paddingTop():int {
			return _usePadding ? padding.getPaddingTop( _container ) : 0;
		}

		private function get paddingBottom():int {
			return _usePadding ? padding.getPaddingBottom( _container ) : 0;
		}
	}
}
