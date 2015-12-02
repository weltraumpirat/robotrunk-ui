package org.robotrunk.ui.core.conf {
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.impl.LeftAutoSizerImpl;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.content.ImageContent;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class UICoreExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );

			injector.map( Padding ).asSingleton();
			injector.map( Position );
			injector.map( UIComponentProvider ).asSingleton();
			injector.map( UIViewImpl );
			injector.map( ImageContent );
			injector.map( LeftAutoSizerImpl );
		}
	}
}
