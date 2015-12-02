package org.robotrunk.ui.form.factory {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.factory.AbstractComponentFactory;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.background.ImageBackgroundImpl;
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;

	public class AbstractInputTextComponentFactory extends AbstractComponentFactory {
		override protected function createComponent():UIComponent {
			var component:UIComponent;
			component = getTextComponentInstance();
			component.style = getComponentStyle();
			component.states = createStateViews();
			return component;
		}

		protected function getTextComponentInstance():UIComponent {
			throw new AbstractMethodInvocationException( "You must override the 'getTextComponentInstance' method." );
			return null;
		}

		private function createStateViews():Dictionary {
			var stateViews:Dictionary = new Dictionary();
			for each( var st:String in parameters.states ) {
				var view:UIView = getViewInstance();
				view.state = st;
				view.style = getComponentStyle( st );
				view.content = getViewContent( view );
				var bg:ImageBackgroundImpl = imageBackgroundOrNull( view );
				view.background = bg ? bg : new RectangleBackgroundImpl();
				view.shadow = new ComponentDropShadow( view as DisplayObject, view.style );
				stateViews[st] = view;
				stateViews[view] = view;
			}
			return stateViews;
		}

		private function imageBackgroundOrNull( view:UIView ):ImageBackgroundImpl {
			var bg:ImageBackgroundImpl = null;
			if( view.style.backgroundImage ) {
				bg = new ImageBackgroundImpl();
				bg.image = parameters.injector.getInstance( MovieClip, view.style.backgroundImage );
				parameters.injector.getInstance( MovieClipHelper ).gotoFrameLabel( bg.image, view.state );
			}
			return bg;
		}

		protected function getViewInstance():UIView {
			return parameters.injector.getInstance( UIViewImpl );
		}

		protected function getViewContent( view:UIView ):Sprite {
			throw new AbstractMethodInvocationException( "You must override the 'getContentInstance' method." );
			view;
			return null;
		}
	}
}
