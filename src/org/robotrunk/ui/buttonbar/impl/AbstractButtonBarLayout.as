package org.robotrunk.ui.buttonbar.impl {
	import flash.display.DisplayObject;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.buttonbar.api.ButtonBarAlignment;
	import org.robotrunk.ui.buttonbar.api.ButtonBarLayout;

	public class AbstractButtonBarLayout implements ButtonBarLayout {
		protected var _offset:Number;

		protected var _xpos:Number;

		protected var _ypos:Number;

		private var _align:ButtonBarAlignment;

		protected function positionButton( button:DisplayObject ):void {
			throw new AbstractMethodInvocationException( "You must override the 'position()' method." );
		}

		public function position( buttons:Vector.<DisplayObject>, offset:Number = 0 ):void {
			init( offset );

			if( validate() ) {
				alignButtons( buttons );
				positionButtons( buttons );
			}
		}

		protected function validate():Boolean {
			throw new AbstractMethodInvocationException( "You must override the 'validate()' method." );
		}

		private function alignButtons( buttons:Vector.<DisplayObject> ):void {
			_align.align( buttons );
		}

		private function positionButtons( buttons:Vector.<DisplayObject> ):void {
			for each( var button:DisplayObject in buttons ) {
				positionButton( button );
			}
		}

		private function init( offset:Number ):void {
			_xpos = 0;
			_ypos = 0;
			_offset = offset;
		}

		public function get align():ButtonBarAlignment {
			return _align;
		}

		public function set align( align:ButtonBarAlignment ):void {
			_align = align;
		}
	}
}
