package org.robotrunk.ui.image.conf {
	import avmplus.getQualifiedClassName;

	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.image.factory.ImageFactory;
	import org.robotrunk.ui.image.impl.ImageImpl;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class ImageExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );

			mapImage();
		}

		private function mapImage():void {
			injector.map( UIComponentProvider,
						  getQualifiedClassName( ImageImpl ) ).toValue( new UIComponentProvider( new ImageFactory() ) );
		}
	}
}
