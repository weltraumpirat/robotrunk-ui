package org.robotrunk.ui.core.api {
	import flash.display.DisplayObject;

	public interface GraphicalElement {
		function addChild( obj:DisplayObject ):DisplayObject;

		function addChildAt( obj:DisplayObject, index:int ):DisplayObject;

		function getChildByName( name:String ):DisplayObject;

		function getChildAt( index:int ):DisplayObject;

		function contains( obj:DisplayObject ):Boolean;

		function get numChildren():int;

		function setChildIndex( obj:DisplayObject, index:int ):void;

		function getChildIndex( obj:DisplayObject ):int;

		function get x():Number;

		function set x( x:Number ):void;

		function get y():Number;

		function set y( y:Number ):void;

		function get width():Number;

		function set width( width:Number ):void;

		function get height():Number;

		function set height( height:Number ):void;

		function get alpha():Number;

		function set alpha( alpha:Number ):void;

		function get visible():Boolean;

		function set visible( visible:Boolean ):void;

		function get mask():DisplayObject;

		function set mask( mask:DisplayObject ):void;
	}
}
