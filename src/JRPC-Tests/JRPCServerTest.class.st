Class {
	#name : #JRPCServerTest,
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
JRPCServerTest >> setUp [
	super setUp.
	server := JRPCServer new.
	
	server
		addHandlerNamed: 'setUpHandler' block: [ 42 ]
]

{ #category : #test }
JRPCServerTest >> testAddHandler [
	| handler |
	self assert: server namesToHandlersDict size equals: 1.
	
	handler := JRPCMockHandler new.
	server addHandler: handler.
	
	self assert: server namesToHandlersDict size equals: 2.
	self assert: (server namesToHandlersDict at: 'mock') equals: handler.
]

{ #category : #test }
JRPCServerTest >> testAddHandlerDuplicated [
	| handler |
	handler := JRPCMockHandler new.
	server addHandler: handler.
	
	self should: [ server addHandler: handler ] raise: JRPCNameOfHandlerIsAlreadyTaken withExceptionDo: [ :error | self assert: error handler equals: handler ]
]

{ #category : #tests }
JRPCServerTest >> testAddHandlerNamedBlock [
	| block |
	self assert: server namesToHandlersDict size equals: 1.
	block := [ :x | x ].
	server addHandlerNamed: 'test' block: block.
	
	self assert: server namesToHandlersDict size equals: 2.
	self assert: (server namesToHandlersDict at: 'test') methodName equals: 'test'.
	self assert: (server namesToHandlersDict at: 'test') block equals: block
]

{ #category : #tests }
JRPCServerTest >> testCheckParamsMatchingForHandlerAndRequest [
	self should: [ 
		server
			checkParamsMatchingForHandler: (JRPCBlockHandler methodName: 'test' block: [ :x | ])
			andRequest: (JRPCRequestObject new)
	] raise: JRPCInvalidParameters.
	
	self should: [ 
		server
			checkParamsMatchingForHandler: (JRPCBlockHandler methodName: 'test' block: [ :x | ])
			andRequest: (JRPCRequestObject new params: #(1 2); yourself)
	] raise: JRPCInvalidParameters.

	self should: [ 
		server
			checkParamsMatchingForHandler: (JRPCBlockHandler methodName: 'test' block: [ :x | ])
			andRequest: (JRPCRequestObject new params: { #x -> 1 . #y -> 2 } asDictionary; yourself)
	] raise: JRPCInvalidParameters.
	
	self should: [ 
		server
			checkParamsMatchingForHandler: (JRPCBlockHandler methodName: 'test' block: [ :x | ])
			andRequest: (JRPCRequestObject new params: { #y -> 1 } asDictionary; yourself)
	] raise: JRPCInvalidParameters.
	
	"The two next will not raise error."
	server
		checkParamsMatchingForHandler: (JRPCBlockHandler methodName: 'test' block: [ :x | ])
		andRequest: (JRPCRequestObject new params: #(1); yourself).
		
	server
		checkParamsMatchingForHandler: (JRPCBlockHandler methodName: 'test' block: [ :x | ])
		andRequest: (JRPCRequestObject new params: { #x -> 1 } asDictionary; yourself)
]

{ #category : #tests }
JRPCServerTest >> testHandleJRPCRequestObject [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler'.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCSuccessResponseObject.
	self assert: response result equals: 42.
]

{ #category : #tests }
JRPCServerTest >> testHandleJRPCRequestObject2 [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: #().
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCSuccessResponseObject.
	self assert: response result equals: 42.
]

{ #category : #tests }
JRPCServerTest >> testHandleJRPCRequestObject3 [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: Dictionary new.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCSuccessResponseObject.
	self assert: response result equals: 42.
]

{ #category : #tests }
JRPCServerTest >> testHandleJRPCRequestObjectInvalidParams [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: { #x -> 1 } asDictionary.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCServerTest >> testHandleJRPCRequestObjectInvalidParams2 [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'setUpHandler' params: #(1 2).
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InvalidParams.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InvalidParams).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCServerTest >> testHandleJRPCRequestObjectInvalidParams3 [
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
JRPCServerTest >> testHandleJRPCRequestObjectInvalidParams4 [
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
JRPCServerTest >> testHandleJRPCRequestObjectInvalidParams5 [
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
JRPCServerTest >> testHandleJRPCRequestObjectNonExistent [
	| requestForNonExistentHandler response |
	requestForNonExistentHandler := JRPCRequestObject id: 1 method: 'nonExistent'.
	
	response := server handleJRPCRequestObject: requestForNonExistentHandler.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: MethodNotFound.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: MethodNotFound).
	self assert: response error data isNil.
]

{ #category : #tests }
JRPCServerTest >> testHandleJSON [
	| jsonResponse |
	jsonResponse := server handleJSON: '{"jsonrpc" : "2.0", "id" : 41, "method" : "setUpHandler"}'.
	
	self assert: jsonResponse equals: '{"jsonrpc":"2.0","result":42,"id":41}'.
	
	jsonResponse := server handleJSON: '{'.
	
	self assert: jsonResponse equals: '{"jsonrpc":"2.0","id":null,"error":{"message":"Invalid JSON was received by the server.","code":-32700}}'
]

{ #category : #tests }
JRPCServerTest >> testHandlerForName [
	| block handler |
	
	self should: [ server handlerForName: 'powerOf2' ] raise: JRPCNonExistentHandler.
	
	block := [ :anInteger | anInteger ** 2 ].
	
	server addHandlerNamed: 'powerOf2' block: block.
	handler := server handlerForName: 'powerOf2'.
	
	self assert: handler methodName equals: 'powerOf2'.
	self assert: handler block equals: block
]

{ #category : #tests }
JRPCServerTest >> testInternalError [
	| requestForInternalError response data |
	server addHandlerNamed: 'divide' block: [ :x :y | x / y ].
	
	requestForInternalError := JRPCRequestObject id: 1 method: 'divide' params: #(1 0).
	
	response := server handleJRPCRequestObject: requestForInternalError.
	
	self assert: response class equals: JRPCErrorResponseObject.
	self assert: response error code equals: InternalError.
	self assert: response error message equals: (JRPCConstantsSharedPool meaningForError: InternalError).
	self assert: response error data isNotNil.
	
	data := response error data.
	self assertCollection: data equals: { 
		'errorClass' -> 'ZeroDivide'.
		'messageText' -> ''.
		'tag' -> ''.
		'signaler' -> '1'.
		'signalerContext' -> 'SmallInteger>>/'
	} asDictionary
]

{ #category : #tests }
JRPCServerTest >> testRemoveHandlerNamed [
	self assert: server namesToHandlersDict size equals: 1.
	self assert: server namesToHandlersDict keys first equals: 'setUpHandler'.
	
	server removeHandlerNamed: 'setUpHandler'.
	
	self assert: server namesToHandlersDict isEmpty.
]
