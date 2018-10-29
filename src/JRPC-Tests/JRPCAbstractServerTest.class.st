Class {
	#name : #JRPCAbstractServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Tests'
}

{ #category : #running }
JRPCAbstractServerTest >> setUp [
	super setUp.
	server := JRPCAbstractServer new.
	
	server
		addHandlerNamed: 'setUpHandler' block: [ 42 ]
]

{ #category : #tests }
JRPCAbstractServerTest >> testAddHandlerNamedBlock [
	| handler |
	self assert: server namesToHandlersDict size equals: 1.
	handler := [ :x | x ].
	server addHandlerNamed: 'test' block: handler.
	
	self assert: server namesToHandlersDict size equals: 2.
	self assert: (server namesToHandlersDict at: 'test') equals: handler
]

{ #category : #tests }
JRPCAbstractServerTest >> testCheckParamsMatchingForHandlerAndRequest [
	self should: [ 
		server
			checkParamsMatchingForHandler: [ :x | ]
			andRequest: (JRPCRequestObject new)
	] raise: JRPCInvalidParameters.
	
	self should: [ 
		server
			checkParamsMatchingForHandler: [ :x | ]
			andRequest: (JRPCRequestObject new params: #(1 2); yourself)
	] raise: JRPCInvalidParameters.

	self should: [ 
		server
			checkParamsMatchingForHandler: [ :x | ]
			andRequest: (JRPCRequestObject new params: { #x -> 1 . #y -> 2 } asDictionary; yourself)
	] raise: JRPCInvalidParameters.
	
	self should: [ 
		server
			checkParamsMatchingForHandler: [ :x | ]
			andRequest: (JRPCRequestObject new params: { #y -> 1 } asDictionary; yourself)
	] raise: JRPCInvalidParameters.
	
	"The two next will not raise error."
	server
		checkParamsMatchingForHandler: [ :x | ]
		andRequest: (JRPCRequestObject new params: #(1); yourself).
		
	server
		checkParamsMatchingForHandler: [ :x | ]
		andRequest: (JRPCRequestObject new params: { #x -> 1 } asDictionary; yourself)
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObject [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler'.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCSuccessResponseObject.
	self assert: response result equals: 42.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObject2 [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: #().
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCSuccessResponseObject.
	self assert: response result equals: 42.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObject3 [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: Dictionary new.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCSuccessResponseObject.
	self assert: response result equals: 42.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObjectInvalidParams [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: { #x -> 1 } asDictionary.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObjectInvalidParams2 [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: #(1 2).
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObjectInvalidParams3 [
	| requestForNonExistentHandler response |
	server addHandlerNamed: '2params' block: [ :x :y | x + y ].
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: '2params' params: #(1).
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObjectInvalidParams4 [
	| requestForNonExistentHandler response |
	server addHandlerNamed: '2params' block: [ :x :y | x + y ].
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: '2params' params: #(1 2 3).
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObjectInvalidParams5 [
	| requestForNonExistentHandler response |
	server addHandlerNamed: '2params' block: [ :x :y | x + y ].
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: '2params'.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJRPCRequestObjectNonExistent [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'nonExistent'.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: MethodNotFound.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: MethodNotFound).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandleJSON [
	| jsonResponse |
	jsonResponse := server handleJSON: '{"jsonrpc" : "2.0", "id" : 41, "method" : "setUpHandler"}'.
	
	self assert: jsonResponse equals: '{"jsonrpc":"2.0","result":42,"id":41}'
]

{ #category : #tests }
JRPCAbstractServerTest >> testHandlerForName [
	| handler |
	
	self should: [ server handlerForName: 'powerOf2' ] raise: JRPCNonExistentHandler.
	
	handler := [ :anInteger | anInteger ** 2 ].
	
	server addHandlerNamed: 'powerOf2' block: handler.
	
	self assert: (server handlerForName: 'powerOf2') equals: handler
]

{ #category : #tests }
JRPCAbstractServerTest >> testRemoveHandlerNamed [
	self assert: server namesToHandlersDict size equals: 1.
	self assert: server namesToHandlersDict keys first equals: 'setUpHandler'.
	
	server removeHandlerNamed: 'setUpHandler'.
	
	self assert: server namesToHandlersDict isEmpty.
]
