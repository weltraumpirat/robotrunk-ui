/*
 * Copyright (c) 2012 Tobias Goeschel.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package org.robotrunk.ui.window.factory {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.factory.AbstractComponentFactory;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.background.ImageBackgroundImpl;
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;
	import org.robotrunk.ui.core.impl.shadow.NoDropShadow;
	import org.robotrunk.ui.window.impl.ScrollablePane;
	import org.robotrunk.ui.window.impl.WindowImpl;

	public class WindowFactory extends AbstractComponentFactory {

		override protected function createComponent():UIComponent {
			var component:UIComponent;
			component = getWindowInstance();
			component.style = getComponentStyle();
			component.states = createStateViews();

			return component;
		}

		protected function getWindowInstance():UIComponent {
			return parameters.injector.getInstance( WindowImpl );
		}

		private function createStateViews():Dictionary {
			var stateViews:Dictionary = new Dictionary();
			for each( var st:String in parameters.states ) {
				var view:UIView = getViewInstance();
				view.state = st;
				view.style = getComponentStyle( st );
				view.background =
				view.style.backgroundImage ? createImageBackground( view ) : new RectangleBackgroundImpl();
				view.shadow = view.style.shadow == "true" || view.style.shadow == true ?
							  new ComponentDropShadow( view as DisplayObject, view.style ) : new NoDropShadow();
				view.content = new ScrollablePane();
				stateViews[st] = view;
				stateViews[view] = view;
			}
			return stateViews;
		}

		protected function getViewInstance():UIView {
			return parameters.injector.getInstance( UIViewImpl );
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
