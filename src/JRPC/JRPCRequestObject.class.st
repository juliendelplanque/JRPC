"
I model a request sent by a client as defined in JSON-RPC 2.0 spec [1].

I MUST hold:
- #method : the method to be called.

I MAY hold:
- #params : the arguments to be given to the handler named #method.

[1]: https://www.jsonrpc.org/specification
"
Class {
	#name : #JRPCRequestObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'method',
		'params'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCRequestObject class >> fromJRPCJSONObject: aDictionary [
	^ (super fromJRPCJSONObject: aDictionary)
		method: (aDictionary at: 'method');
		params: (aDictionary at: 'params' ifAbsent: [ nil ]);
		yourself
]

{ #category : #'instance creation' }
JRPCRequestObject class >> id: anInteger method: aString [
	^ self id: anInteger method: aString params: nil
]

{ #category : #'instance creation' }
JRPCRequestObject class >> id: anInteger method: aString params: anArrayOrDictionary [
	^ self new
		id: anInteger;
		method: aString;
		params: anArrayOrDictionary;
		yourself
]

{ #category : #converting }
JRPCRequestObject >> asJRPCJSON [
	| dict |
	dict := super asJRPCJSON.
	dict
		at: 'method' put: self method asJRPCJSON.
	self params ifNotNil: [
		dict at: 'params' put: self params asJRPCJSON ].
	^ dict
]

{ #category : #'server handling' }
JRPCRequestObject >> beHandledByServer: aJRPCServer [
	^ aJRPCServer handleJRPCRequestObject: self
]

{ #category : #'server handling' }
JRPCRequestObject >> convertErrorToResponse: jrpcError [
	^ jrpcError asJRPCResponseWithId: self id
]

{ #category : #accessing }
JRPCRequestObject >> method [
	^ method
]

{ #category : #accessing }
JRPCRequestObject >> method: anObject [
	method := anObject
]

{ #category : #accessing }
JRPCRequestObject >> params [
	^ params
]

{ #category : #accessing }
JRPCRequestObject >> params: anObject [
	params := anObject
]
