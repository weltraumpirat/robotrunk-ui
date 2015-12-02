package org.robotrunk.ui.core {
	import flash.display.Sprite;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.content.ImageContent;

	public class ImageContentTest {
		private var content:ImageContent;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var position:Position;

		private var style:Style;

		[Before]
		public function setUp():void {
			content = new ImageContent();
			style = new Style();
			content.style = style;
			content.image = new Sprite();
		}

		[Test(async)]
		public function renders():void {
			mockPosition();
			content.position = position;
			Async.proceedOnEvent( this, content, ViewEvent.RENDER );
			Async.proceedOnEvent( this, content, ViewEvent.RENDER_COMPLETE );
			content.render();

			assertTrue( content.contains( content.image ) );
		}

		private function mockPosition():void {
			mock( position ).method( "forTarget" ).args( content ).returns( position );
			mock( position ).method( "within" ).args( instanceOf( Style ) ).returns( position );
			mock( position ).method( "withPadding" ).noArgs().returns( position );
			mock( position ).method( "apply" );
		}

		[After]
		public function tearDown():void {
			content = null;
			style = null;
			position = null;
		}
	}
}
