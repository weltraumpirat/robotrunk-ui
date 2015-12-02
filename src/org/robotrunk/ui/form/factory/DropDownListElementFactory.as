package org.robotrunk.ui.form.factory {
	import flash.utils.Dictionary;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.button.factory.TextSwitchButtonFactory;
	import org.robotrunk.ui.core.api.UIComponent;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.LeftAutoSizerImpl;
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;
	import org.robotrunk.ui.core.impl.shadow.NoDropShadow;
	import org.robotrunk.ui.form.impl.DropDownListElementImpl;
	import org.robotrunk.ui.text.factory.textfield.TextFieldFactory;

	public class DropDownListElementFactory extends TextSwitchButtonFactory {

		override protected function getButtonInstance():UIComponent {
			return parameters.injector.getInstance( DropDownListElementImpl );
		}

		override protected function fail( e:Error ):void {
			parameters.injector.getInstance( Logger ).warn( "Could not inject DropDownListElement|"+parameters.id+" of type:"+parameters.type+" with class:"+parameters.clazz+" and states:"+parameters.states );
			super.fail( e );
		}

		override protected function createStateViews():Dictionary {
			var stateViews:Dictionary = new Dictionary();
			for each( var st:String in parameters.states ) {
				var view:UIView = getViewInstance();
				view.state = st;
				view.style = getComponentStyle( st );
				view.background = view.style.backgroundImage
						? createImageBackground( view )
						: new RectangleBackgroundImpl();
				view.shadow = new NoDropShadow();
				view.autoSizer = view.style.autoSize == "left"
						? parameters.injector.getInstance( LeftAutoSizerImpl )
						: null;
				view.content = getViewContent( view, st );
				stateViews[st] = view;
				stateViews[view] = view;
			}
			return stateViews;
		}

		public function DropDownListElementFactory( textFieldFactory:TextFieldFactory ) {
			super( textFieldFactory );
		}
	}
}
