package org.robotrunk.ui.text {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;

	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotools.graphics.drawing.GraphRectangle;
	import org.robotrunk.ui.text.textfield.tlf.MultiLineTLFTextField;
	import org.robotrunk.ui.text.textfield.tlf.SmartTLFTextField;

	public class SmartTLFTextFieldTest {
		private var textField:SmartTLFTextField;

		private var css:String = ".rtl {text-align:right;direction:rtl;} .ltr{text-align:left;color:#000000; direction:ltr;} .arabic{color:#ff0000;} .hebrew{color:#0000ff;} .english{color:#000000;}";

		private var styleSheet:StyleSheet;

		private var btnArabic:Sprite;

		private var btnHebrew:Sprite;

		private var btnEnglish:Sprite;

		[Before(ui, async)]
		public function setUp():void {
			btnArabic = createButton( 0xFF0000 );
			btnHebrew = createButton( 0x0000FF );
			btnEnglish = createButton( 0x000000 );
			UIImpersonator.addChild( btnArabic );
			btnHebrew.x = 150;
			btnEnglish.x = 300;
			var buttons:Array = [btnArabic, btnHebrew, btnEnglish];
			for each( var btn:Sprite in buttons ) {
				btn.addEventListener( MouseEvent.CLICK, onMouseClick );
				UIImpersonator.addChild( btn );
			}

			styleSheet = new StyleSheet();
			styleSheet.parseCSS( css );

			textField = new MultiLineTLFTextField( styleSheet );
			textField.autoSize = TextFieldAutoSize.RIGHT;
			textField.width = 400;
			textField.height = 200;
			textField.y = 50;

			UIImpersonator.addChild( textField );
		}

		private function createButton( color:uint ):Sprite {
			var spr:Sprite = new Sprite();
			new GraphRectangle( spr ).createRectangle( new Rectangle( 0, 0, 100, 30 ) ).fill( color ).noLine().draw();
			return spr;
		}

		private function onMouseClick( ev:MouseEvent ):void {
			if( ev.target == btnArabic ) {
				textField.htmlText = HtmlTextTestData.arabic;
			}
			if( ev.target == btnHebrew ) {
				textField.htmlText = HtmlTextTestData.hebrew;
			}
			if( ev.target == btnEnglish ) {
				textField.htmlText = HtmlTextTestData.english;
			}
		}

		[Test(ui, async)]
		public function canHoldArabicText():void {
			textField.htmlText = HtmlTextTestData.arabic;
			var timer:Timer = new Timer( 99000, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this, onTimerFinish, 100000 ) );
			timer.start();
		}

		public function onTimerFinish( ev:Event, data:Object ):void {
			assertNull( data );
			assertNotNull( textField );
		}

		[After(ui, async)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			styleSheet = null;
			btnArabic = null;
			btnHebrew = null;
			btnEnglish = null;
			textField = null;
		}
	}
}
