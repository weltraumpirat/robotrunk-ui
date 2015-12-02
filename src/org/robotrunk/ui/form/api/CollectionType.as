package org.robotrunk.ui.form.api {

	public interface CollectionType {
		function get dataProvider():Array;

		function set dataProvider( dataProvider:Array ):void;

		function get selectedItem():*;
	}
}
