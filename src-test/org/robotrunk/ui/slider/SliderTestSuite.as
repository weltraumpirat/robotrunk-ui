package
org.robotrunk.ui.slider {
	import org.robotrunk.ui.slider.factory.HorizontalSliderFactoryTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SliderTestSuite {
		public var horizontalSliderFactoryTest:HorizontalSliderFactoryTest;

		public var horizontalSliderIntegrationTest:HorizontalSliderIntegrationTest;

		public var horizontalSliderTest:HorizontalSliderTest;

		public var sliderButtonTest:SliderButtonTest;

		public var verticalSliderFactoryTest:HorizontalSliderFactoryTest;

		public var verticalSliderIntegrationTest:VerticalSliderIntegrationTest;

		public var verticalSliderTest:VerticalSliderTest;
	}
}
