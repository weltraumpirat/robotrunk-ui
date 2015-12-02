package org.robotrunk.ui.text.conf {
	import avmplus.getQualifiedClassName;

	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.text.api.Label;
	import org.robotrunk.ui.text.api.RichText;
	import org.robotrunk.ui.text.api.RichTextContainer;
	import org.robotrunk.ui.text.factory.component.LabelFactory;
	import org.robotrunk.ui.text.factory.component.RichTextContainerFactory;
	import org.robotrunk.ui.text.factory.component.RichTextFactory;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.robotrunk.ui.text.impl.LabelImpl;
	import org.robotrunk.ui.text.impl.RichTextContainerImpl;
	import org.robotrunk.ui.text.impl.RichTextImpl;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class TextExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		[Inject]
		public var textFieldFactory:TextFieldFactory;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );

			mapComponents();
		}

		private function mapComponents():void {
			mapLabel();
			mapRichText();
			mapRichTextContainer();
		}

		private function mapLabel():void {
			var factory:LabelFactory = new LabelFactory( textFieldFactory );
			var provider:UIComponentProvider = new UIComponentProvider( factory );
			injector.map( Label ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( LabelImpl ) ).toValue( provider );
		}

		private function mapRichText():void {
			var factory:RichTextFactory = new RichTextFactory( textFieldFactory );
			var provider:UIComponentProvider = new UIComponentProvider( factory );
			injector.map( RichText ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( RichTextImpl ) ).toValue( provider );
		}

		private function mapRichTextContainer():void {
			var factory:RichTextContainerFactory = new RichTextContainerFactory( textFieldFactory );
			var provider:UIComponentProvider = new UIComponentProvider( factory );
			injector.map( RichTextContainer ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( RichTextContainerImpl ) ).toValue( provider );
		}
	}
}
