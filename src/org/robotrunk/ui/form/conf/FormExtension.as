package org.robotrunk.ui.form.conf {
	import flash.utils.getQualifiedClassName;

	import org.robotrunk.ui.core.conf.UIComponentProvider;
	import org.robotrunk.ui.form.api.Checkbox;
	import org.robotrunk.ui.form.api.DropDownList;
	import org.robotrunk.ui.form.api.DropDownListElement;
	import org.robotrunk.ui.form.api.InputField;
	import org.robotrunk.ui.form.api.MultipleChoiceGroup;
	import org.robotrunk.ui.form.api.RadioButton;
	import org.robotrunk.ui.form.api.RadioButtonElement;
	import org.robotrunk.ui.form.api.SingleChoiceGroup;
	import org.robotrunk.ui.form.factory.CheckboxFactory;
	import org.robotrunk.ui.form.factory.DropDownListElementFactory;
	import org.robotrunk.ui.form.factory.DropDownListFactory;
	import org.robotrunk.ui.form.factory.InputFieldFactory;
	import org.robotrunk.ui.form.factory.LazyDropDownListFactory;
	import org.robotrunk.ui.form.factory.MultipleChoiceGroupFactory;
	import org.robotrunk.ui.form.factory.RadioButtonElementFactory;
	import org.robotrunk.ui.form.factory.RadioButtonFactory;
	import org.robotrunk.ui.form.factory.SingleChoiceGroupFactory;
	import org.robotrunk.ui.form.impl.CheckboxImpl;
	import org.robotrunk.ui.form.impl.DropDownListElementImpl;
	import org.robotrunk.ui.form.impl.DropDownListImpl;
	import org.robotrunk.ui.form.impl.InputFieldImpl;
	import org.robotrunk.ui.form.impl.LazyDropDownListImpl;
	import org.robotrunk.ui.form.impl.MultipleChoiceGroupImpl;
	import org.robotrunk.ui.form.impl.RadioButtonElementImpl;
	import org.robotrunk.ui.form.impl.RadioButtonImpl;
	import org.robotrunk.ui.form.impl.SingleChoiceGroupImpl;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class FormExtension implements IExtension {
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );

			mapInputField();
			mapDropDownList();
			mapDropDownListElements();
			mapRadioButton();
			mapRadioButtonElements();
			mapCheckbox();
			mapSingleChoiceGroup();
			mapMultipleChoiceGroup();
		}

		private function mapInputField():void {
			var provider:UIComponentProvider = new UIComponentProvider( new InputFieldFactory() );
			injector.map( InputField ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( InputFieldImpl ) ).toValue( provider );
		}

		private function mapDropDownList():void {
			var provider:UIComponentProvider = new UIComponentProvider( new DropDownListFactory() );
			injector.map( DropDownList ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( DropDownListImpl ) ).toValue( provider );

			var lazyProvider:UIComponentProvider = new UIComponentProvider( new LazyDropDownListFactory() );
			injector.map( DropDownList, "lazy" ).toProvider( lazyProvider );
			injector.map( UIComponentProvider, getQualifiedClassName( LazyDropDownListImpl ) ).toValue( lazyProvider );
		}

		private function mapDropDownListElements():void {
			var provider:UIComponentProvider = new UIComponentProvider( new DropDownListElementFactory( injector.getInstance( TextFieldFactory ) ) );
			injector.map( DropDownListElement ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( DropDownListElementImpl ) ).toValue( provider );
		}

		private function mapRadioButton():void {
			var provider:UIComponentProvider = new UIComponentProvider( new RadioButtonFactory() );
			injector.map( RadioButton ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( RadioButtonImpl ) ).toValue( provider );
		}

		private function mapRadioButtonElements():void {
			var provider:UIComponentProvider = new UIComponentProvider( new RadioButtonElementFactory( injector.getInstance( TextFieldFactory ) ) );
			injector.map( RadioButtonElement ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( RadioButtonElementImpl ) ).toValue( provider );
		}

		private function mapCheckbox():void {
			var provider:UIComponentProvider = new UIComponentProvider( new CheckboxFactory() );
			injector.map( Checkbox ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( CheckboxImpl ) ).toValue( provider );
		}

		private function mapSingleChoiceGroup():void {
			var provider:UIComponentProvider = new UIComponentProvider( new SingleChoiceGroupFactory() );
			injector.map( SingleChoiceGroup ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( SingleChoiceGroupImpl ) ).toValue( provider );
		}

		private function mapMultipleChoiceGroup():void {
			var provider:UIComponentProvider = new UIComponentProvider( new MultipleChoiceGroupFactory() );
			injector.map( MultipleChoiceGroup ).toProvider( provider );
			injector.map( UIComponentProvider, getQualifiedClassName( MultipleChoiceGroupImpl ) ).toValue( provider );
		}

	}
}
