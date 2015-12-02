package org.robotrunk.ui.text.factory.component {
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.robotrunk.ui.text.impl.RichTextImpl;

	public class RichTextFactory extends AbstractRichTextElementFactory {
		public function RichTextFactory( textFieldFactory:TextFieldFactory ) {
			super( textFieldFactory );
		}

		override protected function getTextComponentInstance():UIComponent {
			return parameters.injector.getInstance( RichTextImpl );
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject RichTextImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}
	}
}
