package org.robotrunk.ui.button.factory {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.factory.AbstractComponentFactory;
	import org.robotrunk.ui.core.impl.LeftAutoSizerImpl;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.background.ImageBackgroundImpl;
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;
	import org.robotrunk.ui.core.impl.shadow.NoDropShadow;

	public class AbstractButtonFactory extends AbstractComponentFactory {
		override protected function createComponent():UIComponent {
			var component:UIComponent;
			component = getButtonInstance();
			component.style = getComponentStyle();
			component.states = createStateViews();
			return component;
		}

		protected function getButtonInstance():UIComponent {
			throw new AbstractMethodInvocationException( "You must override the 'getButtonInstance' method." );
		}

		protected function getViewInstance():UIView {
			return parameters.injector.getInstance( UIViewImpl );
		}

		protected function getViewContent( view:UIView, state:String ):Sprite {
			throw new AbstractMethodInvocationException( "You must override the 'getViewContent' method." );
		}

		protected function createStateViews():Dictionary {
			var stateViews:Dictionary = new Dictionary();
			for each( var st:String in parameters.states ) {
				var view:UIView = getViewInstance();
				view.state = st;
				view.style = getComponentStyle( st );
				view.background = view.style.backgroundImage
						? createImageBackground( view )
						: new RectangleBackgroundImpl();
				view.shadow = view.style.shadow == "true" || view.style.shadow == true ?
							  new ComponentDropShadow( view as DisplayObject, view.style ) : new NoDropShadow();
				view.autoSizer = view.style.autoSize == "left"
						? parameters.injector.getInstance( LeftAutoSizerImpl )
						: null;
				view.content = getViewContent( view, st );
				stateViews[st] = view;
				stateViews[view] = view;
			}
			return stateViews;
		}

		protected function createImageBackground( view:UIView ):ImageBackgroundImpl {
			var bg:ImageBackgroundImpl = new ImageBackgroundImpl();
			bg.style = view.style;
			bg.image = parameters.injector.getInstance( MovieClip, view.style.backgroundImage );
			parameters.injector.getInstance( MovieClipHelper ).gotoFrameLabel( bg.image, view.state );
			return bg;
		}
	}
}
