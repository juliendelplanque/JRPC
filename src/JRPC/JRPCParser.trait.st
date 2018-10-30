"
Utility trait to parse JSON-RPC messages and convert model objects to JSON.
"
Trait {
	#name : #JRPCParser,
	#category : #'JRPC-Traits'
}

{ #category : #converting }
JRPCParser >> convertJRPCJsonableObjectToJSON: aJRPCJsonableObject [
	^ String streamContents: [ :stream |
		self convertJRPCJsonableObjectToJSON: aJRPCJsonableObject asJRPCJSON on: stream ]
]

{ #category : #converting }
JRPCParser >> convertJRPCJsonableObjectToJSON: aJRPCJsonableObject on: aStream [
	STONJSON put: aJRPCJsonableObject onStream: aStream
]

{ #category : #parsing }
JRPCParser >> parseSupposedJRPCMessageObjectFromStream: aStream [
	"Try to parse a JRPCDictionaryObject that should be held by aStream
	 (but we're not sure at this point).
	 Generate understandable errors if there is a problem."
	| dictionary |
	dictionary := STONJSON fromStream: aStream.
	^ (JRPCMessageObject classToInstantiateForDictionary: dictionary)
			fromJRPCJSONObject: dictionary
]

{ #category : #parsing }
JRPCParser >> parseSupposedJRPCMessageObjectFromString: aString [
	^ aString readStreamDo: [ :stream |
		self parseSupposedJRPCMessageObjectFromStream: stream ]
]
