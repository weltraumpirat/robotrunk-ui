package {
	import flash.display.Sprite;
	import flash.system.Security;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;
	import org.robotrunk.ui.button.ButtonTestSuite;
	import org.robotrunk.ui.buttonbar.ButtonBarTestSuite;
	import org.robotrunk.ui.core.CoreTestSuite;
	import org.robotrunk.ui.form.FormTestSuite;
	import org.robotrunk.ui.image.ImageTestSuite;
	import org.robotrunk.ui.slider.SliderTestSuite;
	import org.robotrunk.ui.text.TextTestSuite;
	import org.swiftsuspenders.Injector;

	public class MainTestRunner extends Sprite {
		public static var injector:Injector;

		private var core:FlexUnitCore;

		public function MainTestRunner() {
			trace( "Flash Player runs in sandbox:"+Security.sandboxType );

			core = new FlexUnitCore();

			VisualTestEnvironmentBuilder.getInstance( this );

			core.addListener( new TraceListener() );
			core.addListener( new CIListener() );

			core.run( CoreTestSuite,
					  ButtonTestSuite,
					  ButtonBarTestSuite,
					  FormTestSuite,
					  ImageTestSuite,
					  SliderTestSuite,
					  TextTestSuite );
		}
	}
}
