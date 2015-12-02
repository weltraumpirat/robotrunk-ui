package org.robotrunk.ui.core {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;

	import mockolate.runner.MockolateRule;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.content.TextImageContent;
	import org.robotrunk.ui.text.textfield.tlf.UIComponentTLFTextField;

	public class TextImageContentTest {
		private var content:TextImageContent;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var position:Position;

		private var textField:UIComponentTLFTextField;

		private var image:Sprite;

		private var text:String = "<text><p><span class=\"multiple\">It is a text.</span></p></text>";

		private var style:Style;

		[Before]
		public function setUp():void {
			content = new TextImageContent();
			content.padding = new Padding();
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( ".test{font-family:Arial; font-size:12px; font-weight:normal; color:#000000;}" );
			textField = new UIComponentTLFTextField( styleSheet );
			content.textField = textField;

			image = new Sprite();
			with( image.graphics ) {
				beginFill( 0, 1 );
				drawRect( 0, 0, 100, 100 );
				endFill();
			}
			content.image = image;
			var container:UIComponent = new UIComponent();
			container.addChild( content );
			UIImpersonator.addChild( container );
		}

		[Test(async)]
		public function rendersLeftMiddleAligned():void {
			style = new Style();
			style.clazz = "test";
			style.autoSize = "left";
			style.iconPosition = "left";
			style.verticalAlign = "middle";
			style.offset = 5;
			content.style = style;
			content.htmlText = text;
			Async.proceedOnEvent( this, content, ViewEvent.RENDER );
			textField.addEventListener( Event.ADDED_TO_STAGE,
										Async.asyncHandler( this, assertLeftMiddleAligned, 500 ) );
			content.render();
		}

		private function assertLeftMiddleAligned( ev:Event, data:* = null ):void {
			assertNotNull( ev );
			assertNull( data );
			assertEquals( text, content.htmlText );
			assertTrue( content.contains( content.image ) );
			assertEquals( 0, content.image.x );
			assertEquals( 0, content.image.y );
			assertTrue( content.contains( textField ) );
			assertEquals( Math.abs( textField.height-content.image.height )*.5, textField.y );
			assertEquals( 105, textField.x );
		}

		[Test(async)]
		public function rendersRightBottomAligned():void {
			style = new Style();
			style.clazz = "test";
			style.autoSize = "left";
			style.iconPosition = "right";
			style.textAlign = "right";
			style.verticalAlign = "bottom";
			style.offset = 5;
			content.style = style;

			content.htmlText = text;
			Async.proceedOnEvent( this, content, ViewEvent.RENDER );
			textField.addEventListener( Event.ADDED_TO_STAGE, Async.asyncHandler( this, assertRightAligned, 500 ) );
			content.render();
		}

		private function assertRightAligned( ev:Event, data:* = null ):void {
			assertNotNull( ev );
			assertNull( data );
			assertEquals( text, content.htmlText );
			assertTrue( content.contains( content.image ) );
			assertEquals( textField.width+5, content.image.x );
			assertEquals( 0, content.image.y );
			assertTrue( content.contains( textField ) );
			assertEquals( Math.abs( textField.height-content.image.height ), textField.y );
			assertEquals( 0, textField.x );
			assertEquals( 0, content.x );
		}

		[After]
		public function tearDown():void {
			content = null;
			style = null;
		}
	}
}
