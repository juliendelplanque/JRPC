"
I am an abstract client for JSON-RPC 2.0.

My subclasses define how to transmit JSON-RPC objects to a server.

To define that, #sendRequest: message should be overriden by my subclasses.
"
Class {
	#name : #JRPCAbstractClient,
	#superclass : #Object,
	#traits : 'JRPCParser',
	#classTraits : 'JRPCParser classTrait',
	#category : #'JRPC-Clients'
}

{ #category : #api }
JRPCAbstractClient >> callMethod: aString arguments: anObject withId: anInteger [
	"Call a method which takes arguments."
	^ self sendRequest: (JRPCRequestObject new
								id: anInteger;
								method: aString;
								params: anObject;
								yourself)
]

{ #category : #api }
JRPCAbstractClient >> callMethod: aString withId: anInteger [
	"Call a method which takes no arguments."
	^ self callMethod: aString arguments: nil withId: anInteger
]

{ #category : #parsing }
JRPCAbstractClient >> parseSupposedJRPCMessageObjectFromStream: aStream [
	"Try to parse a JRPCDictionaryObject that should be held by aStream
	 (but we're not sure at this point).
	 Generate understandable errors if there is a problem."
	| dictionary |
	dictionary := STONJSON fromStream: aStream.
	^ (JRPCMessageObject classToInstantiateForDictionary: dictionary)
			fromJRPCJSONObject: dictionary
]

{ #category : #'private - sending' }
JRPCAbstractClient >> sendRequest: aJRPCRequestObject [
	"To be implemented by concrete subclasses.
	 Sends aJRPCRequestObject to the server to which the client is connected.
	 Returns a JRPCSuccessResponseObject if everything goes well.
	 Returns a JRPCErrorResponse if something went wrong.
	"
	
	^ self subclassResponsibility
]
