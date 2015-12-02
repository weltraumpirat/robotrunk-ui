package org.robotrunk.ui.text.factory.component {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.factory.AbstractComponentFactory;
	import org.robotrunk.ui.core.impl.LeftAutoSizerImpl;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.background.ImageBackgroundImpl;
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;
	import org.robotrunk.ui.core.impl.content.TextContent;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;
	import org.robotrunk.ui.core.impl.shadow.NoDropShadow;
	import org.robotrunk.ui.text.textfield.UITextField;

	public class AbstractTextComponentFactory extends AbstractComponentFactory {
		override protected function createComponent():UIComponent {
			var component:UIComponent;
			component = getTextComponentInstance();
			component.style = getComponentStyle();
			component.states = createStateViews();
			return component;
		}

		protected function getTextComponentInstance():UIComponent {
			throw new AbstractMethodInvocationException( "You must override the 'getTextComponentInstance' method." );
		}

		private function createStateViews():Dictionary {
			var stateViews:Dictionary = new Dictionary();
			for each( var st:String in parameters.states ) {
				var view:UIView = getViewInstance();
				view.state = st;
				view.style = getComponentStyle( st );
				view.content = getViewContent( view, st );
				var bg:ImageBackgroundImpl = imageBackgroundOrNull( view );
				view.background = bg ? bg : new RectangleBackgroundImpl();
				view.shadow = view.style.shadow == "true" || view.style.shadow == true ?
							  new ComponentDropShadow( view as DisplayObject, view.style ) : new NoDropShadow();
				view.autoSizer =
				view.style.autoSize == "left" ? parameters.injector.getInstance( LeftAutoSizerImpl ) : null;
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

		protected function getViewContent( view:UIView, state:String ):Sprite {
			var style:Style = view.style;
			var content:TextContent = parameters.injector.getInstance( TextContent );
			content.style = style;
			content.textField = createTextField( style, state );
			return content;
		}

		protected function isMultiLine( style:Style ):* {
			return style.multiline && style.wordWrap;
		}

		protected function isWordWrap( style:Style ):Boolean {
			return style.wordWrap == null || style.wordWrap == true;
		}

		protected function isSelectable( style:Style ):Boolean {
			return style.selectable == true || style.selectable == "true";
		}

		protected function createTextField( style:Style, state:String ):UITextField {
			throw new AbstractMethodInvocationException( "You must override the 'createTextField' method." );
		}
	}
}
