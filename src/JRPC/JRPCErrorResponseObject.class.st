"
I model a unsuccessful response answered to a client by the server as defined in JSON-RPC 2.0 spec [1].

I MUST hold:
- #error : an instance of JRPCErrorObject which models the error which occured during the handler execution.

[1]: https://www.jsonrpc.org/specification
"
Class {
	#name : #JRPCErrorResponseObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'error'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCErrorResponseObject class >> fromJRPCJSONObject: aDictionary [
	^ (super fromJRPCJSONObject: aDictionary)
		error: (aDictionary at: 'error')
]

{ #category : #'instance creation' }
JRPCErrorResponseObject class >> id: anInteger error: aJRPCErrorObject [
	^ self new
		id: anInteger;
		error: aJRPCErrorObject
]

{ #category : #converting }
JRPCErrorResponseObject >> asJRPCJSON [
	^ super asJRPCJSON
		at: 'error' put: self error asJRPCJSON;
		yourself
]

{ #category : #accessing }
JRPCErrorResponseObject >> error [
	^ error
]

{ #category : #accessing }
JRPCErrorResponseObject >> error: anObject [
	error := anObject
]
