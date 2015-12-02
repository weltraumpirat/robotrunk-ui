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

package
org.robotrunk.ui {
	import org.robotrunk.ui.button.*;
	import org.robotrunk.ui.button.factory.AbstractButtonFactoryTest;
	import org.robotrunk.ui.button.factory.SimpleButtonFactoryTest;
	import org.robotrunk.ui.button.factory.SwitchButtonFactoryTest;
	import org.robotrunk.ui.button.factory.TextButtonFactoryTest;
	import org.robotrunk.ui.button.factory.TextSwitchButtonFactoryTest;
	import org.robotrunk.ui.button.factory.TextToggleButtonFactoryTest;
	import org.robotrunk.ui.button.factory.ToggleButtonFactoryTest;
	import org.robotrunk.ui.buttonbar.ButtonBarFactoryTest;
	import org.robotrunk.ui.buttonbar.ButtonBarLayoutTest;
	import org.robotrunk.ui.buttonbar.PaletteButtonBarTest;
	import org.robotrunk.ui.buttonbar.RelayButtonBarTest;
	import org.robotrunk.ui.buttonbar.SwitchButtonBarTest;
	import org.robotrunk.ui.core.AbstractComponentFactoryTest;
	import org.robotrunk.ui.core.CreationParametersTest;
	import org.robotrunk.ui.core.ImageBackgroundTest;
	import org.robotrunk.ui.core.ImageContentTest;
	import org.robotrunk.ui.core.LeftAutoSizerTest;
	import org.robotrunk.ui.core.PaddingTest;
	import org.robotrunk.ui.core.PositionTest;
	import org.robotrunk.ui.core.RectangleBackgroundTest;
	import org.robotrunk.ui.core.StyleMapTest;
	import org.robotrunk.ui.core.StyleTest;
	import org.robotrunk.ui.core.TextContentTest;
	import org.robotrunk.ui.core.TextImageContentTest;
	import org.robotrunk.ui.core.UIComponentProviderTest;
	import org.robotrunk.ui.core.UIComponentTest;
	import org.robotrunk.ui.core.UIViewTest;
	import org.robotrunk.ui.form.CheckboxTest;
	import org.robotrunk.ui.form.DropDownListElementTest;
	import org.robotrunk.ui.form.DropDownListTest;
	import org.robotrunk.ui.form.RadioButtonElementTest;
	import org.robotrunk.ui.form.RadioButtonTest;
	import org.robotrunk.ui.form.factory.CheckboxFactoryTest;
	import org.robotrunk.ui.form.factory.DropDownListElementFactoryTest;
	import org.robotrunk.ui.form.factory.InputFieldFactoryTest;
	import org.robotrunk.ui.form.factory.RadioButtonElementFactoryTest;
	import org.robotrunk.ui.image.ImageFactoryTest;
	import org.robotrunk.ui.image.ImageTest;
	import org.robotrunk.ui.slider.HorizontalSliderIntegrationTest;
	import org.robotrunk.ui.slider.HorizontalSliderTest;
	import org.robotrunk.ui.slider.SliderButtonTest;
	import org.robotrunk.ui.slider.VerticalSliderIntegrationTest;
	import org.robotrunk.ui.slider.VerticalSliderTest;
	import org.robotrunk.ui.slider.factory.HorizontalSliderFactoryTest;
	import org.robotrunk.ui.slider.factory.VerticalSliderFactoryTest;
	import org.robotrunk.ui.text.CSSFormatResolverTest;
	import org.robotrunk.ui.text.LabelTest;
	import org.robotrunk.ui.text.factory.LabelFactoryTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class UITestSuite {
		// button

		public var abstractButtonFactoryTest:AbstractButtonFactoryTest;

		public var simpleButtonFactoryTest:SimpleButtonFactoryTest;

		public var simpleButtonTest:SimpleButtonTest;

		public var switchButtonFactoryTest:SwitchButtonFactoryTest;

		public var textButtonFactoryTest:TextButtonFactoryTest;

		public var textSwitchButtonFactoryTest:TextSwitchButtonFactoryTest;

		public var textToggleButtonFactoryTest:TextToggleButtonFactoryTest;

		public var toggleButtonFactoryTest:ToggleButtonFactoryTest;

		public var toggleButtonTest:ToggleButtonTest;

		// buttonbar

		public var buttonBarFactoryTest:ButtonBarFactoryTest;

		public var buttonBarLayoutTest:ButtonBarLayoutTest;

		public var paletteButtonBarTest:PaletteButtonBarTest;

		public var relayButtonBarTest:RelayButtonBarTest;

		public var switchButtonBarTest:SwitchButtonBarTest;

		// core

		public var abstractComponentFactoryTest:AbstractComponentFactoryTest;

		public var creationParametersTest:CreationParametersTest;

		public var imageBackgroundTest:ImageBackgroundTest;

		public var imageContentTest:ImageContentTest;

		public var leftAutoSizerTest:LeftAutoSizerTest;

		public var paddingTest:PaddingTest;

		public var positionTest:PositionTest;

		public var rectangleBackgroundTest:RectangleBackgroundTest;

		public var styleMapTest:StyleMapTest;

		public var styleTest:StyleTest;

		public var textContentTest:TextContentTest;

		public var textImageContentTest:TextImageContentTest;

		public var uIComponentProviderTest:UIComponentProviderTest;

		public var uIComponentTest:UIComponentTest;

		public var uIViewTest:UIViewTest;

		// form

		public var checkboxFactoryTest:CheckboxFactoryTest;

		public var checkboxTest:CheckboxTest;

		public var dropDownListTest:DropDownListTest;

		public var dropDownListElementTest:DropDownListElementTest;

		public var dropDownListElementFactoryTest:DropDownListElementFactoryTest;

		public var inputFieldFactoryTest:InputFieldFactoryTest;

		public var radioButtonTest:RadioButtonTest;

		public var radioButtonElementTest:RadioButtonElementTest;

		public var radioButtonElementFactoryTest:RadioButtonElementFactoryTest;

		// image

		public var imageFactoryText:ImageFactoryTest;

		public var imageTest:ImageTest;

		// slider

		public var horizontalSliderFactoryTest:HorizontalSliderFactoryTest;

		public var horizontalSliderIntegrationTest:HorizontalSliderIntegrationTest;

		public var horizontalSliderTest:HorizontalSliderTest;

		public var sliderButtonTest:SliderButtonTest;

		public var verticalSliderFactoryTest:VerticalSliderFactoryTest;

		public var verticalSliderIntegrationTest:VerticalSliderIntegrationTest;

		public var verticalSliderTest:VerticalSliderTest;

		// text

		public var cSSFormatResolverTest:CSSFormatResolverTest;

		public var labelFactoryTest:LabelFactoryTest;

		public var labelTest:LabelTest;

		//For completeness: This is a user-clickable ui test, to be run occasionally, but not automated!
		//public var smartTextFieldTest : SmartTextFieldTest;
	}
}
