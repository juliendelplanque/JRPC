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

{ #category : #test }
JRPCServerTest >> messageProcessor [

	^ server messageProcessor
]

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

	self
		assert: self messageProcessor handledMethodsCount equals: 1;
		deny: ( self messageProcessor canHandleMethodNamed: 'mock' ).

	handler := JRPCMockHandler new.
	server addHandler: handler.

	self
		assert: self messageProcessor handledMethodsCount equals: 2;
		assert: ( self messageProcessor canHandleMethodNamed: 'mock' )
]

{ #category : #test }
JRPCServerTest >> testAddHandlerDuplicated [

	| handler |

	handler := JRPCMockHandler new.
	server addHandler: handler.

	self
		should: [ server addHandler: handler ]
		raise: JRPCNameOfHandlerIsAlreadyTaken
		withExceptionDo: [ :error | self assert: error handler equals: handler ]
]

{ #category : #tests }
JRPCServerTest >> testAddHandlerNamedBlock [

	| block |

	self assert: self messageProcessor handledMethodsCount equals: 1.
	block := [ :x | x ].
	server addHandlerNamed: 'test' block: block.

	self assert: self messageProcessor handledMethodsCount equals: 2.
	self assert: ( self messageProcessor canHandleMethodNamed: 'test' )
]

{ #category : #test }
JRPCServerTest >> testAddHandlersFromPragmasIn [

	| exampleStack |

	self assert: self messageProcessor handledMethodsCount equals: 1.

	exampleStack := JRPCExampleStack new.
	server addHandlersFromPragmasIn: exampleStack.

	self
		assert: self messageProcessor handledMethodsCount equals: 4;
		assert: ( self messageProcessor canHandleMethodNamed: 'stack_top' );
		assert: ( self messageProcessor canHandleMethodNamed: 'stack_pop' );
		assert: ( self messageProcessor canHandleMethodNamed: 'stack_push' )
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

	self
		assert: self messageProcessor handledMethodsCount equals: 1;
		assert: ( self messageProcessor canHandleMethodNamed: 'setUpHandler' ).

	server removeHandlerNamed: 'setUpHandler'.

	self assert: self messageProcessor handledMethodsCount equals: 0
]
