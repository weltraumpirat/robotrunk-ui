package org.robotrunk.ui.image.factory {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.content.ImageContent;
	import org.robotrunk.ui.image.impl.ImageImpl;

	public class ImageFactory extends AbstractImageFactory {
		override protected function getImageInstance():UIComponent {
			return parameters.injector.getInstance( ImageImpl );
		}

		override protected function getViewContent( view:UIView ):Sprite {
			var content:ImageContent = parameters.injector.getInstance( ImageContent );
			content.style = view.style;
			var img:String = view.style.icon;
			if( img ) {
				content.image = parameters.injector.getInstance( DisplayObject, img );
				parameters.injector.getInstance( MovieClipHelper ).gotoFrameLabel( content.image, view.state );
			}
			return content;
		}
	}
}
