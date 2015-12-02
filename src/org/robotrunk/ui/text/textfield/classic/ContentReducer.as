package org.robotrunk.ui.text.textfield.classic {
	public class ContentReducer {
		private var _reducedList:Array;
		private var _className:String;
		private var _text:String;

		public function reduce( list:Array ):Array {
			_reducedList = [];
			_className = null;
			_text = "";
			for each ( var chunk:TextChunk in list ) {
				if( !chunk.isEmpty() ) {
					if( bufferIsEmpty() ) {
						loadChunkIntoBuffer( chunk );
					} else if( chunkHasANewStyle( chunk ) ) {
						appendCurrentBufferedChunkToReducedList();
						loadChunkIntoBuffer( chunk )
					} else {
						appendChunkTextToBufferedChunk( chunk );
					}
				}
			}
			appendCurrentBufferedChunkToReducedList();
			return _reducedList;
		}

		private function bufferIsEmpty():Boolean {
			return !_className;
		}

		private function loadChunkIntoBuffer( chunk:TextChunk ):void {
			_className = chunk.clazz;
			_text = chunk.text;
		}

		private function chunkHasANewStyle( chunk:TextChunk ):Boolean {
			return _className != chunk.clazz;
		}

		private function appendCurrentBufferedChunkToReducedList():void {
			if( !bufferIsEmpty() ) {
				_reducedList[_reducedList.length] = new TextChunk( _text, _className );
			}
		}

		private function appendChunkTextToBufferedChunk( chunk:TextChunk ):void {
			_text += chunk.text;
		}

		public function clear():void {
			_text = null;
			_className = null;
			_reducedList = null;
		}
	}
}
