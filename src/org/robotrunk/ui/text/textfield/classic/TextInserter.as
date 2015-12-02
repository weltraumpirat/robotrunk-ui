package org.robotrunk.ui.text.textfield.classic {
	public class TextInserter {
		private var _content:Array;
		private var _endIndex:int;
		private var _currentIndex:int;

		private var _replacedContent:Array;
		private var _chunkReplacementStartIndex:int;
		private var _numberOfChunksToReplace:int;
		private var _selectionStart:int;
		private var _selectionEnd:int;

		public function insert( insertText:String, selectionStart:int, selectionEnd:int, className:String = null ):Array {
			initialize( selectionStart, selectionEnd );
			replaceText( insertText, className );
			return assembleUpdatedContent();
		}

		private function replaceText( insertText:String, className:String ):void {
			for each ( var chunk:TextChunk in _content ) {
				applyTextInsertionToChunk( chunk, insertText, className );
			}
			_endIndex = _selectionStart+insertText.length;
		}

		private function applyTextInsertionToChunk( chunk:TextChunk, insertText:String, className:String ):void {
			if( chunkIsWithinRangeOfSelection( chunk ) ) {
				replaceTextInChunk( chunk, insertText, className );
			} else {
				_chunkReplacementStartIndex++;
			}
			_currentIndex = nextChunkIndex( chunk );
		}

		private function replaceTextInChunk( chunk:TextChunk, insertText:String, className:String ):void {
			_numberOfChunksToReplace++;
			if( replacementShouldStartAtCurrentChunk() ) {
				appendLeadingTextAsFirstChunk( chunk );
			}
			if( chunkIsWithinRangeOfReplacement( chunk ) ) {
				appendNewTextChunk( insertText, getDefaultStyle( className ) );
				if( replacementShouldEndAtCurrentChunk( chunk ) ) {
					appendTrailingTextAsLastChunk( chunk );
				}
				// break;
			}
		}

		private function initialize( selectionStart:int, selectionEnd:int ):void {
			_selectionStart = selectionStart;
			_selectionEnd = selectionEnd;
			_currentIndex = _chunkReplacementStartIndex = _numberOfChunksToReplace = 0;
			_replacedContent = [];
		}

		private function assembleUpdatedContent():Array {
			var newContent:Array = [];
			newContent = newContent.concat( _content.slice( 0, _chunkReplacementStartIndex ) );
			newContent = newContent.concat( _replacedContent );
			newContent = newContent.concat( _content.slice( _chunkReplacementStartIndex+_numberOfChunksToReplace ) );
			return newContent;
		}

		private function getDefaultStyle( className:String ):String {
			return className != null ? className : getLastUsedStyleClass();
		}

		private function chunkIsWithinRangeOfSelection( chunk:TextChunk ):Boolean {
			return nextChunkIndex( chunk )>=_selectionStart;
		}

		private function appendTrailingTextAsLastChunk( chunk:TextChunk ):void {
			_replacedContent[_replacedContent.length] = new TextChunk( chunk.text.substr( replacementEndIndex( chunk ) ),
																	   chunk.clazz );
		}

		private function replacementShouldEndAtCurrentChunk( chunk:TextChunk ):Boolean {
			return replacementEndIndex( chunk )<chunk.text.length;
		}

		private function appendNewTextChunk( insertText:String, className:String ):void {
			_replacedContent[_replacedContent.length] = new TextChunk( insertText, "."+className );
		}

		private function appendLeadingTextAsFirstChunk( chunk:TextChunk ):void {
			_replacedContent[_replacedContent.length] =
			new TextChunk( chunk.text.substr( 0, replacementStartIndex() ), chunk.clazz );
		}

		private function getLastUsedStyleClass():* {
			var lastOriginalChunk:TextChunk = getLastOriginalChunk();
			var lastReplacedChunk:TextChunk = getLastReplacedChunk();
			return lastReplacedChunk != null
					? lastReplacedChunk.clazz.substr( 1 )
					: lastOriginalChunk != null
						   ? lastOriginalChunk.clazz.substr( 1 )
						   : _content[0].clazz.substr( 1 );
		}

		private function getLastReplacedChunk():* {
			return _replacedContent.length>0
					? _replacedContent[_replacedContent.length-1]
					: null;
		}

		private function getLastOriginalChunk():* {
			return _chunkReplacementStartIndex>0
					? _content[_chunkReplacementStartIndex-1]
					: null;
		}

		private function chunkIsWithinRangeOfReplacement( chunk:TextChunk ):Boolean {
			return nextChunkIndex( chunk )>=_selectionEnd;
		}

		private function replacementShouldStartAtCurrentChunk():Boolean {
			return _replacedContent.length<1 && replacementStartIndex()>0;
		}

		private function replacementStartIndex():int {
			return _replacedContent.length<1 ? _selectionStart-_currentIndex : 0;
		}

		private function replacementEndIndex( chunk:TextChunk ):int {
			return nextChunkIndex( chunk )>_selectionEnd ? _selectionEnd-_currentIndex : chunk.text.length;
		}

		private function nextChunkIndex( chunk:TextChunk ):int {
			return _currentIndex+chunk.text.length;
		}

		public function get endIndex():int {
			return _endIndex;
		}

		public function TextInserter( content:Array ) {
			_content = content;
		}

		public function clear():void {
			_content = null;
			_replacedContent = null;
			_chunkReplacementStartIndex = _currentIndex = _endIndex = 0;
			_numberOfChunksToReplace = _selectionEnd = _selectionStart = 0;
		}
	}
}
