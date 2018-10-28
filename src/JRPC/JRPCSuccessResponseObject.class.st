"
I model a successful response answered to a client by the server as defined in JSON-RPC 2.0 spec [1].

I MUST hold:
- #result : the result of the evaluation of the handler converted as a Dictionary which can be serialized to JSON.

[1]: https://www.jsonrpc.org/specification
"
Class {
	#name : #JRPCSuccessResponseObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'result'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCSuccessResponseObject class >> fromDictionary: aDictionary [
	^ (super fromDictionary: aDictionary)
		result: (aDictionary at: 'result')
]

{ #category : #'instance creation' }
JRPCSuccessResponseObject class >> id: anInteger result: anObject [
	^ self new
		id: anInteger;
		result: anObject;
		yourself
]

{ #category : #'dictionary building' }
JRPCSuccessResponseObject >> buildDictionary: aDictionary [
	super buildDictionary: aDictionary.
	aDictionary
		at: 'result' put: self result
]

{ #category : #accessing }
JRPCSuccessResponseObject >> result [
	^ result
]

{ #category : #accessing }
JRPCSuccessResponseObject >> result: anObject [
	result := anObject
]
