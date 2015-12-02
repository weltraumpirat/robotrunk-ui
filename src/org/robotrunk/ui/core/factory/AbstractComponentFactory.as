package org.robotrunk.ui.core.factory {
	import flash.utils.Dictionary;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIComponentFactory;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.swiftsuspenders.Injector;

	public class AbstractComponentFactory implements UIComponentFactory {
		public var parameters:CreationParameters;

		public function create( injector:Injector, params:Dictionary ):UIComponent {
			parameters = new CreationParameters( injector, params );
			return tryCreateComponent();
		}

		protected function tryCreateComponent():UIComponent {
			var component:UIComponent = null;
			try {
				component = createComponent();
			} catch( e:Error ) {
				fail( e );
			} finally {
				destroy();
			}
			return component;
		}

		protected function getComponentStyle( state:String = null ):Style {
			var append:String = state ? ":"+state : "";
			var type:String = parameters.type+append;
			var clazz:String = parameters.clazz+append;
			var id:String = parameters.id+append;
			var style:Style = parameters.styleMap.getComponentStyleCascaded( type, clazz, id );
			style.type = type;
			style.clazz = clazz;
			style.id = id;
			return style;
		}

		protected function createComponent():UIComponent {
			throw new AbstractMethodInvocationException( "You must implement the 'createComponent' method." );
		}

		protected function fail( e:Error ):void {
			if( !parameters.optional ) {
				throw e;
			}
		}

		public function destroy():void {
			if( parameters ) {
				parameters.destroy();
			}
			parameters = null;
		}
	}
}
