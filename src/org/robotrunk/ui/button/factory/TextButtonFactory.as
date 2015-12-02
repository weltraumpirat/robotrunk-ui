package org.robotrunk.ui.button.factory {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.StyleSheet;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.button.impl.TextButtonImpl;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.content.TextImageContent;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;
	import org.robotrunk.ui.text.textfield.UITextField;

	public class TextButtonFactory extends AbstractButtonFactory {
		private var _textFieldFactory:TextFieldFactory;

		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( TextButtonImpl );
		}

		override protected function getViewContent( view:UIView, state:String ):Sprite {
			var style:Style = view.style;
			var icon:String = style.icon;
			var content:TextImageContent = parameters.injector.getInstance( TextImageContent );
			content.style = style;
			content.textField = createTextField( style, state );
			content.image = icon ? createIcon( icon, view.state ) : null;
			return content;
		}

		protected function createTextField( style:Style, state:String ):UITextField {
			var styleSheet:StyleSheet = parameters.styleMap.consolidatedStyleSheet;
			var tf:UITextField = isMultiline( style )
					? _textFieldFactory.createMultiLineTextField( styleSheet )
					: _textFieldFactory.createSingleLineTextField( styleSheet );
			tf.clazz = parameters.clazz;
			tf.componentType = parameters.type;
			tf.id = parameters.id;
			tf.state = state;
			tf.style = style;
			return tf;
		}

		private function isMultiline( style:Style ):* {
			return (style.multiline == "true" || style.multiline == true) && (style.wordWrap == "true" || style.wordWrap == true);
		}

		private function createIcon( img:String, frame:String ):MovieClip {

			var mov:MovieClip = parameters.injector.getInstance( MovieClip, img );
			parameters.injector.getInstance( MovieClipHelper ).gotoFrameLabel( mov, frame );
			return mov;
		}

		override protected function fail( e:Error ):void {
			var msg:String = parameters != null
					? "Could not inject TextButtonImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states
					: "No parameters injected!";
			try {
				parameters.injector.getInstance( Logger ).warn( msg );
			}
			catch( ignore:Error ) {
				trace( msg, "No Logger:"+ignore.getStackTrace() );
			}
			super.fail( e );
		}

		public function TextButtonFactory( textFieldFactory:TextFieldFactory ) {
			_textFieldFactory = textFieldFactory;
		}
	}
}
