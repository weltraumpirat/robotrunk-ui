package org.robotrunk.ui.buttonbar.factory {
	import org.robotrunk.ui.buttonbar.api.ButtonBarLayout;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarAlign;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarMode;
	import org.robotrunk.ui.buttonbar.conf.ButtonBarOrientation;
	import org.robotrunk.ui.buttonbar.impl.AbstractButtonBarImpl;
	import org.robotrunk.ui.buttonbar.impl.BottomButtonBarAlignmentImpl;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutCenter;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutDown;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutLeft;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutRight;
	import org.robotrunk.ui.buttonbar.impl.ButtonBarLayoutUp;
	import org.robotrunk.ui.buttonbar.impl.CenterButtonBarAlignmentImpl;
	import org.robotrunk.ui.buttonbar.impl.LeftButtonBarAlignmentImpl;
	import org.robotrunk.ui.buttonbar.impl.MiddleButtonBarAlignmentImpl;
	import org.robotrunk.ui.buttonbar.impl.PaletteButtonBarImpl;
	import org.robotrunk.ui.buttonbar.impl.RelayButtonBarImpl;
	import org.robotrunk.ui.buttonbar.impl.RightButtonBarAlignmentImpl;
	import org.robotrunk.ui.buttonbar.impl.SwitchButtonBarImpl;
	import org.robotrunk.ui.buttonbar.impl.TopButtonBarAlignmentImpl;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.api.UIComponent;

	public class ButtonBarFactory extends AbstractButtonBarFactory {
		override protected function getButtonBarInstance():UIComponent {
			var component:AbstractButtonBarImpl;
			var style:Style = parameters.styleMap.getComponentStyleCascaded( parameters.type, parameters.clazz,
																			 parameters.id );
			component = getComponentInstance( style.mode );
			var orientation:String = style.orientation ? style.orientation : "";
			var align:String = style.align ? style.align : "";
			component.layout = getComponentLayout( orientation.toUpperCase(), align.toUpperCase() );
			component.style = style;
			return component;
		}

		protected function getComponentLayout( orientation:String, align:String ):ButtonBarLayout {
			var LayoutType:Class = getLayoutType( orientation );

			var layout:ButtonBarLayout = new LayoutType() as ButtonBarLayout;
			var AlignType:Class = isHorizontalAligned( orientation ) ? getHorizontalAlignType( align ) :
								  getVerticalAlignType( align );
			layout.align = new AlignType();
			return layout;
		}

		private function isHorizontalAligned( orientation:String ):Boolean {
			return orientation == ButtonBarOrientation.DOWN || orientation == ButtonBarOrientation.UP;
		}

		private function getHorizontalAlignType( align:String ):Class {
			return align == ButtonBarAlign.RIGHT ? RightButtonBarAlignmentImpl :
				   align == ButtonBarAlign.CENTER ? CenterButtonBarAlignmentImpl : LeftButtonBarAlignmentImpl;
		}

		private function getVerticalAlignType( align:String ):Class {
			return align == ButtonBarAlign.TOP ? TopButtonBarAlignmentImpl :
				   align == ButtonBarAlign.BOTTOM ? BottomButtonBarAlignmentImpl : MiddleButtonBarAlignmentImpl;
		}

		private function getLayoutType( orientation:String ):Class {
			return orientation == ButtonBarOrientation.RIGHT ? ButtonBarLayoutRight :
				   orientation == ButtonBarOrientation.CENTER ? ButtonBarLayoutCenter :
				   orientation == ButtonBarOrientation.UP ? ButtonBarLayoutUp :
				   orientation == ButtonBarOrientation.DOWN ? ButtonBarLayoutDown : ButtonBarLayoutLeft;
		}

		private function getComponentInstance( mode:String ):AbstractButtonBarImpl {
			var type:Class = mode == ButtonBarMode.SWITCH ? SwitchButtonBarImpl :
							 mode == ButtonBarMode.RELAY ? RelayButtonBarImpl : PaletteButtonBarImpl;

			return parameters.injector.getInstance( type );
		}
	}
}
