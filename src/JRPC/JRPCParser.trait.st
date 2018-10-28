"
Utility trait to parse JSON-RPC messages and convert model objects to JSON.
"
Trait {
	#name : #JRPCParser,
	#category : #'JRPC-Traits'
}

{ #category : #converting }
JRPCParser >> convertJRPCDictionaryObjectToJSON: aJRPCDictionaryObject [
	^ String streamContents: [ :stream |
		self convertJRPCDictionaryObjectToJSON: aJRPCDictionaryObject on: stream ]
]

{ #category : #converting }
JRPCParser >> convertJRPCDictionaryObjectToJSON: aJRPCDictionaryObject on: aStream [
	STONJSON put: aJRPCDictionaryObject asDictionary onStream: aStream
]

{ #category : #parsing }
JRPCParser >> parseSupposedJRPCMessageObjectFromStream: aStream [
	"Try to parse a JRPCDictionaryObject that should be held by aStream
	 (but we're not sure at this point).
	 Generate understandable errors if there is a problem."
	| dictionary |
	dictionary := STONJSON fromStream: aStream.
	^ (JRPCMessageObject classToInstantiateForDictionary: dictionary)
			fromDictionary: dictionary
]

{ #category : #parsing }
JRPCParser >> parseSupposedJRPCMessageObjectFromString: aString [
	^ aString readStreamDo: [ :stream |
		self parseSupposedJRPCMessageObjectFromStream: stream ]
]
