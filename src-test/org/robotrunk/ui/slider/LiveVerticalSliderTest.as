package org.robotrunk.ui.slider {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.common.logging.impl.TraceLoggerImpl;
	import org.robotrunk.common.utils.MovieClipHelper;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIView;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.background.ImageBackgroundImpl;
	import org.robotrunk.ui.core.impl.content.EmptyContent;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;
	import org.robotrunk.ui.slider.api.SliderButton;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;
	import org.robotrunk.ui.slider.impl.VerticalSliderImpl;

	public class LiveVerticalSliderTest extends Sprite {
		private var slider:VerticalSliderImpl;

		private var logger:Logger = new TraceLoggerImpl();

		public function LiveVerticalSliderTest() {
			slider = new VerticalSliderImpl();
			slider.log = logger;
			slider.padding = new Padding();
			slider.position = new Position();
			slider.position.padding = new Padding();
			slider.style = getComponentStyle( "slider" );
			slider.states = createStateViews( "slider" );
			slider.button = createButton() as DisplayObject;
			addChild( slider );
		}

		private function createButton():SliderButton {
			var button:SliderButtonImpl = new SliderButtonImpl();
			button.log = logger;
			button.style = getComponentStyle( "sliderbutton" );
			button.states = createStateViews( "sliderbutton" );
			return button;
		}

		private function createStateViews( type:String ):Dictionary {
			var stateViews:Dictionary = new Dictionary();
			var states:Array = ["default", "over"];
			for each( var st:String in states ) {
				var view:UIView = getViewInstance();
				view.state = st;
				view.style = getComponentStyle( type, st );
				view.background = createImageBackground( type, view );
				view.shadow = new ComponentDropShadow( view as DisplayObject, view.style );
				view.content = new EmptyContent();
				stateViews[st] = view;
				stateViews[view] = view;
			}
			return stateViews;
		}

		private function getComponentStyle( type:String, st:String = null ):Style {
			var style:Style = new Style();
			style.clazz = st ? type+":"+st : type;
			style.id = st ? type+":"+st : type;
			style.type = st ? type+":"+st : type;
			if( type == "slider" ) {
				style.width = 20;
				style.height = 300;
				style.paddingTop = style.paddingBottom = 3;
				style.backgroundImage = "ScrollbarBackground";
			} else {
				style.width = 16;
				style.height = 20;
				style.backgroundImage = "ScrollbarButton";
			}
			return style;
		}

		protected function createImageBackground( type:String, view:UIView ):ImageBackgroundImpl {
			var bg:ImageBackgroundImpl = new ImageBackgroundImpl();
			bg.style = view.style;
			bg.image = type == "slider" ? new ScrollbarBackground() : new ScrollbarButton();
			new MovieClipHelper().gotoFrameLabel( bg.image, view.state );
			return bg;
		}

		protected function getViewInstance():UIView {
			var view:UIViewImpl = new UIViewImpl();
			view.position = new Position();
			view.position.padding = new Padding();
			return view;
		}
	}
}
