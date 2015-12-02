package org.robotrunk.ui.text.textfield.classic {
	public class TextChunk {
		public var text:String;
		public var clazz:String;

		public function TextChunk( text:String, clazz:String ) {
			this.text = text;
			this.clazz = clazz;
		}

		public function isEmpty():Boolean {
			return text == null || text == "" || clazz == ".";
		}
	}
}
