"
I model an error object as defined in JSON-RPC 2.0 spec [1].

To be valid, I MUST hold:
- #code: an Integer which is the code of the error.
- #message : a concise String which explains briefly the error.

Additionally, I can hold additional information in:
- #data : an Dictionary providing additional information about the error.

[1]: https://www.jsonrpc.org/specification
"
Class {
	#name : #JRPCErrorObject,
	#superclass : #JRPCJsonableObject,
	#instVars : [
		'code',
		'message',
		'data'
	],
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCErrorObject class >> code: code message: message [
	^ self code: code message: message data: nil
]

{ #category : #'instance creation' }
JRPCErrorObject class >> code: code message: message data: data [
	^ self new
		code: code;
		message: message;
		data: data;
		yourself
]

{ #category : #'instance creation' }
JRPCErrorObject class >> internalError [
	^ self withPredefinedErrorCode: InternalError
]

{ #category : #'instance creation' }
JRPCErrorObject class >> invalidParams [
	^ self withPredefinedErrorCode: InvalidParams
]

{ #category : #'instance creation' }
JRPCErrorObject class >> invalidRequest [
	^ self withPredefinedErrorCode: InvalidRequest
]

{ #category : #'instance creation' }
JRPCErrorObject class >> methodNotFound [
	^ self withPredefinedErrorCode: MethodNotFound
]

{ #category : #'instance creation' }
JRPCErrorObject class >> parseError [
	^ self withPredefinedErrorCode: ParseError
]

{ #category : #'instance creation' }
JRPCErrorObject class >> withPredefinedErrorCode: anInteger [
	^ self code: anInteger message: (ErrorCodesToMeaningDict at: anInteger)
]

{ #category : #converting }
JRPCErrorObject >> asJRPCJSON [
	| dict |
	dict := Dictionary new.
	dict at: 'code' put: self code.
	dict at: 'message' put: self message.
	(self data isNotNil and: [ self data isDictionary ])
		ifTrue: [ dict at: 'data' put: self data ].
	^ dict
]

{ #category : #accessing }
JRPCErrorObject >> code [
	^ code
]

{ #category : #accessing }
JRPCErrorObject >> code: anObject [
	code := anObject
]

{ #category : #accessing }
JRPCErrorObject >> data [
	^ data
]

{ #category : #accessing }
JRPCErrorObject >> data: anObject [
	data := anObject
]

{ #category : #accessing }
JRPCErrorObject >> message [
	^ message
]

{ #category : #accessing }
JRPCErrorObject >> message: anObject [
	message := anObject
]
