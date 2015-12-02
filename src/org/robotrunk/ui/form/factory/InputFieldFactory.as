package org.robotrunk.ui.form.factory {
	import flash.display.Sprite;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.background.EmptyBackgroundImpl;
	import org.robotrunk.ui.core.impl.content.EmptyContent;
	import org.robotrunk.ui.core.impl.shadow.NoDropShadow;
	import org.robotrunk.ui.form.UIComponentInputTLFTextField;
	import org.robotrunk.ui.form.impl.InputFieldImpl;
	import org.robotrunk.ui.form.impl.InputTextContent;

	public class InputFieldFactory extends AbstractInputTextComponentFactory {
		override protected function createComponent():UIComponent {
			var component:UIComponent = super.createComponent();
			component["input"] = getInputViewInstance( component );
			return component;
		}

		override protected function getTextComponentInstance():UIComponent {
			return parameters.injector.getInstance( InputFieldImpl );
		}

		protected function getInputViewInstance( component:UIComponent ):UIView {
			var input:UIView = getViewInstance();
			input.style = component.style;
			input.content = getViewContent( input );
			input.background = new EmptyBackgroundImpl();
			input.shadow = new NoDropShadow();
			return input;
		}

		override protected function getViewContent( view:UIView ):Sprite {
			return view.state ? parameters.injector.getInstance( EmptyContent ) : getInputViewContent( view );
		}

		private function getInputViewContent( view:UIView ):Sprite {
			var content:InputTextContent = parameters.injector.getInstance( InputTextContent );
			content.textField = new UIComponentInputTLFTextField( view.style, new Padding() );
			content.style = view.style;
			return content;
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject InputFieldImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}
	}
}
