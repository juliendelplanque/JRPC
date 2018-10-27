Class {
	#name : #JRPCAbstractClient,
	#superclass : #Object,
	#category : #'JRPC-Clients'
}

{ #category : #converting }
JRPCAbstractClient >> convertJRPCDictionaryObjectToJSON: aJRPCDictionaryObject [
	^ String streamContents: [ :stream |
		self convertJRPCDictionaryObjectToJSON: aJRPCDictionaryObject on: stream ]
]

{ #category : #converting }
JRPCAbstractClient >> convertJRPCDictionaryObjectToJSON: aJRPCDictionaryObject on: aStream [
	STONJSON put: aJRPCDictionaryObject asDictionary onStream: aStream
]

{ #category : #parsing }
JRPCAbstractClient >> parseSupposedJRPCMessageObjectFromStream: aStream [
	"Try to parse a JRPCDictionaryObject that should be held by aStream
	 (but we're not sure at this point).
	 Generate understandable errors if there is a problem."
	| dictionary |
	dictionary := STONJSON fromStream: aStream.
	^ (JRPCMessageObject classToInstantiateForDictionary: dictionary)
			fromDictionary: dictionary
]

{ #category : #parsing }
JRPCAbstractClient >> parseSupposedJRPCMessageObjectFromString: aString [
	^ aString readStreamDo: [ :stream |
		self parseSupposedJRPCMessageObjectFromStream: stream ]
]

{ #category : #sending }
JRPCAbstractClient >> sendRequest: aJRPCRequestObject [
	"To be implemented by concrete subclasses.
	 Sends aJRPCRequestObject to the server to which the client is connected.
	 Returns a JRPCSuccessResponseObject if everything goes well.
	 Returns a JRPCErrorResponse if something went wrong.
	"
	
	^ self subclassResponsibility
]
