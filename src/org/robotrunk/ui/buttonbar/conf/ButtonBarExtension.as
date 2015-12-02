package org.robotrunk.ui.buttonbar.conf {
	import avmplus.getQualifiedClassName;

	import org.robotrunk.ui.buttonbar.api.ButtonBar;
	import org.robotrunk.ui.buttonbar.factory.ButtonBarFactory;
	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class ButtonBarExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );
			var provider:UIComponentProvider = new UIComponentProvider( new ButtonBarFactory() );
			injector.map( UIComponentProvider, getQualifiedClassName( ButtonBar ) ).toValue( provider );
		}
	}
}
