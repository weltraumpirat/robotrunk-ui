package org.robotrunk.ui.button.conf {
	import avmplus.getQualifiedClassName;

	import org.robotrunk.ui.button.factory.SimpleButtonFactory;
	import org.robotrunk.ui.button.factory.SwitchButtonFactory;
	import org.robotrunk.ui.button.factory.TextButtonFactory;
	import org.robotrunk.ui.button.factory.TextSwitchButtonFactory;
	import org.robotrunk.ui.button.factory.TextToggleButtonFactory;
	import org.robotrunk.ui.button.factory.ToggleButtonFactory;
	import org.robotrunk.ui.button.impl.SimpleButtonImpl;
	import org.robotrunk.ui.button.impl.SwitchButtonImpl;
	import org.robotrunk.ui.button.impl.TextButtonImpl;
	import org.robotrunk.ui.button.impl.TextSwitchButtonImpl;
	import org.robotrunk.ui.button.impl.TextToggleButtonImpl;
	import org.robotrunk.ui.button.impl.ToggleButtonImpl;
	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class ButtonExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		[Inject]
		public var textFieldFactory:TextFieldFactory;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );
			mapImageButtons();
			mapTextButtons();
		}

		private function mapImageButtons():void {
			mapSimpleButton();
			mapSwitchButton();
			mapToggleButton();
		}

		private function mapToggleButton():void {
			injector.map( UIComponentProvider,
						  getQualifiedClassName( ToggleButtonImpl ) ).toValue( new UIComponentProvider( new ToggleButtonFactory() ) );
		}

		private function mapSwitchButton():void {
			injector.map( UIComponentProvider,
						  getQualifiedClassName( SwitchButtonImpl ) ).toValue( new UIComponentProvider( new SwitchButtonFactory() ) );
		}

		private function mapSimpleButton():void {
			injector.map( UIComponentProvider,
						  getQualifiedClassName( SimpleButtonImpl ) ).toValue( new UIComponentProvider( new SimpleButtonFactory() ) );
		}

		private function mapTextButtons():void {
			mapTextButton();
			mapTextSwitchButton();
			mapTextToggleButton();
		}

		private function mapTextToggleButton():void {
			var buttonFactory:TextToggleButtonFactory = new TextToggleButtonFactory( textFieldFactory );
			mapButtonFactory( buttonFactory, getQualifiedClassName( TextToggleButtonImpl ) );
		}

		private function mapTextSwitchButton():void {
			var buttonFactory:TextSwitchButtonFactory = new TextSwitchButtonFactory( textFieldFactory );
			mapButtonFactory( buttonFactory, getQualifiedClassName( TextSwitchButtonImpl ) );
		}

		private function mapTextButton():void {
			var buttonFactory:TextButtonFactory = new TextButtonFactory( textFieldFactory );
			mapButtonFactory( buttonFactory, getQualifiedClassName( TextButtonImpl ) );
		}

		private function mapButtonFactory( buttonFactory:TextButtonFactory, className:String ):void {
			var provider:UIComponentProvider = new UIComponentProvider( buttonFactory );
			injector.map( UIComponentProvider, className ).toValue( provider );
		}
	}
}
