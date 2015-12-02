package org.robotrunk.ui.slider {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
	import org.robotrunk.ui.core.impl.background.RectangleBackgroundImpl;
	import org.robotrunk.ui.core.impl.content.EmptyContent;
	import org.robotrunk.ui.core.impl.content.ImageContent;
	import org.robotrunk.ui.core.impl.shadow.ComponentDropShadow;
	import org.robotrunk.ui.slider.api.SliderButton;
	import org.robotrunk.ui.slider.impl.HorizontalSliderImpl;
	import org.robotrunk.ui.slider.impl.SliderButtonImpl;

	public class LiveHorizontalSliderTest extends Sprite {
		private var slider:HorizontalSliderImpl;

		private var logger:Logger = new TraceLoggerImpl();

		public function LiveHorizontalSliderTest() {
			slider = new HorizontalSliderImpl();
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
				view.background = view.style.backgroundImage ? createImageBackground( view )
						: new RectangleBackgroundImpl();
				view.shadow = new ComponentDropShadow( view as DisplayObject, view.style );
				view.content = type == "sliderbutton" ? createButtonContent( view ) : new EmptyContent();
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
				style.width = 300;
				style.height = 20;
				style.paddingLeft = style.paddingRight = 3;
				style.backgroundImage = "ScrollbarBackground";
			} else {
				style.width = 20;
				style.height = 16;
				style.icon = "ScrollbarButton";
			}
			return style;
		}

		private function createButtonContent( view:UIView ):ImageContent {
			var content:ImageContent = new ImageContent();
			content.style = view.style;
			content.image = new ScrollbarButton();
			new MovieClipHelper().gotoFrameLabel( content.image as MovieClip, view.state );
			content.position = new Position();
			content.position.padding = new Padding();
			return content;
		}

		protected function createImageBackground( view:UIView ):ImageBackgroundImpl {
			var bg:ImageBackgroundImpl = new ImageBackgroundImpl();
			bg.style = view.style;
			bg.image = new ScrollbarBackground();
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
