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

{ #category : #testing }
JRPCParser >> isClient [
	"Returns true if the trait is used in the context of a client, false in the context of a server."
	^ self explicitRequirement
]

{ #category : #parsing }
JRPCParser >> parseSupposedJRPCMessageObjectFromStream: aStream [
	"Try to parse a JRPCDictionaryObject that should be held by aStream
	 (but we're not sure at this point).
	 Generate understandable errors if there is a problem."
	| jsonObject |
	jsonObject := STONJSON fromStream: aStream.
	^ (JRPCMessageObject classToInstantiateForJSONObject: jsonObject forClient: self isClient)
			fromJRPCJSONObject: jsonObject
]

{ #category : #parsing }
JRPCParser >> parseSupposedJRPCMessageObjectFromString: aString [
	^ aString readStreamDo: [ :stream |
		self parseSupposedJRPCMessageObjectFromStream: stream ]
]
