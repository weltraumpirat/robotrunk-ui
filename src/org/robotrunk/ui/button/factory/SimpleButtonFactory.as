package org.robotrunk.ui.button.factory {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.button.impl.SimpleButtonImpl;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.content.EmptyContent;
	import org.robotrunk.ui.core.impl.content.ImageContent;

	public class SimpleButtonFactory extends AbstractButtonFactory {
		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( SimpleButtonImpl );
		}

		override protected function getViewContent( view:UIView, state:String ):Sprite {
			var img:String = view.style.icon;
			return img != null && img != "null" ? createImageContent( view, img ) : new EmptyContent();
		}

		private function createImageContent( view:UIView, img:String ):ImageContent {
			var content:ImageContent = parameters.injector.getInstance( ImageContent );
			content.style = view.style;
			content.image = parameters.injector.getInstance( MovieClip, img );
			parameters.injector.getInstance( MovieClipHelper ).gotoFrameLabel( content.image, view.state );
			return content;
		}

		override protected function fail( e:Error ):void {
			var msg:String = parameters != null
					? "Could not inject SimpleButtonImpl|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states
					: "No parameters injected!";
			try {
				parameters.injector.getInstance( Logger ).warn( msg );
			}
			catch( ignore:Error ) {
				trace( msg, "No Logger:"+ignore.getStackTrace() );
			}
			super.fail( e );
		}
	}
}
