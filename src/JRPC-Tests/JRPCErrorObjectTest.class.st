Class {
	#name : #JRPCErrorObjectTest,
	#superclass : #TestCase,
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Tests'
}

{ #category : #tests }
JRPCErrorObjectTest >> testAsDictionary [
	| dict |
	dict := JRPCErrorObject internalError asDictionary.
	
	self assertCollection: dict keys hasSameElements: #('code' 'message').
	self assert: (dict at: 'code') equals: InternalError.
	self assert: (dict at: 'message') equals: (JRPCConstantsSharedPool meaningForError: InternalError).
	
	dict := (JRPCErrorObject code: 0 message: 'Error for testing' data: { 'help' -> 'Do not panic, this is just for test.' } asDictionary) asDictionary.
	
	self assertCollection: dict keys hasSameElements: #('code' 'message' 'data').
	self assert: (dict at: 'code') equals: 0.
	self assert: (dict at: 'message') equals: 'Error for testing'.
	self assertCollection: (dict at: 'data') keys hasSameElements: #('help').
	self assert: ((dict at: 'data') at: 'help') equals: 'Do not panic, this is just for test.'.
]

{ #category : #tests }
JRPCErrorObjectTest >> testInstanceCreationInternalError [
	| instance |
	instance := JRPCErrorObject internalError.
	
	self assert: instance code equals: InternalError.
	self assert: instance message equals: (JRPCConstantsSharedPool meaningForError: InternalError).
	self assert: instance data isNil
]

{ #category : #tests }
JRPCErrorObjectTest >> testInstanceCreationInvalidParams [
	| instance |
	instance := JRPCErrorObject invalidParams.
	
	self assert: instance code equals: InvalidParams.
	self assert: instance message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: instance data isNil
]

{ #category : #tests }
JRPCErrorObjectTest >> testInstanceCreationInvalidRequest [
	| instance |
	instance := JRPCErrorObject invalidRequest.
	
	self assert: instance code equals: InvalidRequest.
	self assert: instance message equals: (JRPCConstantsSharedPool meaningForError: InvalidRequest).
	self assert: instance data isNil
]

{ #category : #tests }
JRPCErrorObjectTest >> testInstanceCreationMethodNotFound [
	| instance |
	instance := JRPCErrorObject methodNotFound.
	
	self assert: instance code equals: MethodNotFound.
	self assert: instance message equals: (JRPCConstantsSharedPool meaningForError: MethodNotFound).
	self assert: instance data isNil
]

{ #category : #tests }
JRPCErrorObjectTest >> testInstanceCreationParseError [
	| instance |
	instance := JRPCErrorObject parseError.
	
	self assert: instance code equals: ParseError.
	self assert: instance message equals: (JRPCConstantsSharedPool meaningForError: ParseError).
	self assert: instance data isNil
]
