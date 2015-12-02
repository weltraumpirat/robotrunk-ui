package org.robotrunk.ui.core.conf {
	import flash.utils.Dictionary;

	import org.robotrunk.ui.core.api.UIComponentFactory;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.dependencyproviders.DependencyProvider;

	public class UIComponentProvider implements DependencyProvider {
		private var _factory:UIComponentFactory;

		public function UIComponentProvider( factory:UIComponentFactory ) {
			_factory = factory;
		}

		public function apply( targetType:Class, activeInjector:Injector, injectParameters:Dictionary ):Object {
			return _factory.create( activeInjector, injectParameters );
		}

		public function destroy():void {
			_factory.destroy();
			_factory = null;
		}
	}
}
