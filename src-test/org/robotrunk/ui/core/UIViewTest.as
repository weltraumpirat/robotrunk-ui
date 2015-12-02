package org.robotrunk.ui.core {
	import flash.events.Event;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.core.api.AutoSizer;
	import org.robotrunk.ui.core.api.Shadow;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.background.EmptyBackgroundImpl;
	import org.robotrunk.ui.core.impl.content.EmptyContent;

	public class UIViewTest {
		private var view:UIViewImpl;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var position:Position;

		[Mock]
		public var autoSizer:AutoSizer;

		[Mock]
		public var shadow:Shadow;

		[Mock]
		public var background:EmptyBackgroundImpl;

		[Before]
		public function setUp():void {
			view = new UIViewImpl();
		}

		[Test(async, ui)]
		public function rendersWhenAddedToStage():void {
			view.style = new Style();

			mockDependencies();

			Async.proceedOnEvent( this, view, ViewEvent.RENDER );
			Async.proceedOnEvent( this, view.content, Event.ADDED_TO_STAGE );
			Async.proceedOnEvent( this, view, ViewEvent.RENDER_COMPLETE );

			var container:UIComponent = new UIComponent();
			container.addChild( view );
			UIImpersonator.addChild( container );
		}

		[Test(async, ui)]
		public function destroyedWhenRemovedFromStage():void {
			view.style = new Style();
			mockDependencies();
			mockDestroyMethods();

			var container:UIComponent = new UIComponent();
			container.addChild( view );
			UIImpersonator.addChild( container );

			assertDependenciesWereCreated();

			Async.proceedOnEvent( this, view, Event.REMOVED_FROM_STAGE );
			UIImpersonator.removeChild( container );

			assertDependenciesWereDestroyed();
		}

		private function mockDependencies():void {
			mockBackground();
			view.content = new EmptyContent();
			mockShadow();
			view.position = new Position();
			view.position.padding = new Padding();
		}

		private function mockDestroyMethods():void {
			mock( background ).method( "destroy" ).noArgs();
			mock( shadow ).method( "clear" ).noArgs();
		}

		private function assertDependenciesWereCreated():void {
			assertNotNull( view.style );
			assertNotNull( view.content );
			assertNotNull( view.background );
			assertNotNull( view.position );
			assertNotNull( view.shadow );
		}

		private function assertDependenciesWereDestroyed():void {
			assertNull( view.style );
			assertNull( view.content );
			assertNull( view.background );
			assertNull( view.position );
			assertNull( view.shadow );
		}

		private function mockShadow():void {
			mock( shadow ).method( "create" ).noArgs();
			view.shadow = shadow;
		}

		private function mockBackground():void {
			mock( background ).method( "draw" ).args( instanceOf( Style ) );
			view.background = background;
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			view = null;
			position = null;
			rule = null;
			shadow = null;
		}
	}
}
