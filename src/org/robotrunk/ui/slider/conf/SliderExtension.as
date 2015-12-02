package org.robotrunk.ui.slider.conf {
	import avmplus.getQualifiedClassName;

	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.core.impl.content.ImageContent;
	import org.robotrunk.ui.slider.factory.HorizontalSliderFactory;
	import org.robotrunk.ui.slider.factory.SliderButtonFactory;
	import org.robotrunk.ui.slider.factory.VerticalSliderFactory;
	import org.robotrunk.ui.slider.impl.HorizontalSliderImpl;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;
	import org.robotrunk.ui.slider.impl.VerticalSliderImpl;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class SliderExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );
			injector.map( HorizontalSliderFactory );
			injector.map( SliderButtonFactory );
			var horizontalProvider:UIComponentProvider = new UIComponentProvider( injector.getInstance( HorizontalSliderFactory ) );
			var verticalProvider:UIComponentProvider = new UIComponentProvider( injector.getInstance( VerticalSliderFactory ) );
			injector.map( UIComponentProvider,
						  getQualifiedClassName( HorizontalSliderImpl ) ).toValue( horizontalProvider );
			injector.map( UIComponentProvider,
						  getQualifiedClassName( VerticalSliderImpl ) ).toValue( verticalProvider );
			injector.map( HorizontalSliderImpl );
			injector.map( VerticalSliderImpl );
			injector.map( SliderButtonImpl );
			injector.map( ImageContent );
			injector.map( Padding );
			injector.map( Style );
		}
	}
}
