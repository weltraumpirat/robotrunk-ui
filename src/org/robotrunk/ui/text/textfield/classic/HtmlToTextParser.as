package org.robotrunk.ui.text.textfield.classic {
	import org.robotools.text.brToNewline;
	import org.robotools.text.stripLineBreaks;

	public class HtmlToTextParser {
		private static const CLASS:String = "class";
		private static const TEXT:String = "text";

		private var _source:XML;
		public var reducer:ContentReducer;

		public function parse( str:String ):Array {
			var parsed:Array = [];
			try {
				_source = new XML( brToNewline( stripLineBreaks( str ) ) );
				for each ( var p:XML in _source.elements( "p" ) ) {
					parsed = reduceContent( parsed.concat( processParagraph( p ) ) );
				}
				_source = null;
			} catch( e:Error ) {
				trace( "Error parsing XML:"+str+"::"+e );
			}
			return parsed;
		}

		private function processParagraph( p:XML ):Array {
			var styledParagraph:Array = parseSourceNode( p );
			if( !isLastParagraph( p ) ) {
				addLineBreak( styledParagraph );
			}
			return styledParagraph;
		}

		private function isLastParagraph( paragraph:XML ):Boolean {
			return paragraph.childIndex() == _source.children().length();
		}

		private function addLineBreak( styledParagraph:Array ):void {
			styledParagraph[styledParagraph.length-1].text += "\n";
		}

		private function parseSourceNode( sourceNode:XML ):Array {
			var className:String = "."+sourceNode.attribute( CLASS ).toString();
			var textPieces:Array = [];
			for each ( var child:XML in sourceNode.children() ) {
				textPieces = textPieces.concat( processChildNode( child, className ) );
			}
			return textPieces;
		}

		private function processChildNode( child:XML, className:String ):Array {
			return isTextNode( child )
					? processTextNode( child, className )
					: hasStyleClass( child )
						   ? parseSourceNode( child )
						   : [];

		}

		private function isTextNode( child:XML ):Boolean {
			return child.nodeKind() == TEXT;
		}

		private function processTextNode( child:XML, className:String ):Array {
			var piece:TextChunk = new TextChunk( child.toString(), className );
			return !piece.isEmpty() ? [piece] : [];
		}

		private function hasStyleClass( child:XML ):Boolean {
			return child.attribute( CLASS ) != null && child.attribute( CLASS ).toString() != "";
		}

		private function reduceContent( list:Array ):Array {
			reducer ||= new ContentReducer();
			return list != null && list.length != 0
					? reducer.reduce( list )
					: list;
		}
	}
}




