package org.robotrunk.ui.text.textfield.classic {
	import org.robotools.text.lineBreaksToBr;

	public class TextToHtmlConverter {
		public function convert( content:Array ):String {
			var ret:String = "<text><p>";
			for each ( var entry:* in content ) {
				ret += createSpan( entry );
			}
			ret += "</p></text>";
			return ret;
		}

		private function createSpan( entry:* ):String {
			return beginSpan( entry )+lineBreaksToBr( entry.text )+endSpan();
		}

		private function endSpan():String {
			return "</span>";
		}

		private function beginSpan( obj:* ):String {
			var cls:String = styleClassForEntry( obj );
			return "<span class=\""+cls.substr( 1 )+"\">";
		}

		private function styleClassForEntry( entry:* ):* {
			return entry && entry.clazz ? entry.clazz : ".multiple";
		}
	}
}
