"
I am capable of processing JSON-RPC 2.0 messages.

To configure me you can use one of the messages in the 'handlers management' protocol.

A JSON RPC server must solve the specific transport details and handle to me the processing of any incoming message.
"
Class {
	#name : #JRPCMessageProcessor,
	#superclass : #Object,
	#traits : 'JRPCParser',
	#classTraits : 'JRPCParser classTrait',
	#instVars : [
		'handlersByName'
	],
	#category : #'JRPC-Server-Core'
}

{ #category : #'handlers management' }
JRPCMessageProcessor >> addHandler: aJRPCHandler [

	handlersByName
		at: aJRPCHandler methodName
		ifPresent: [ JRPCNameOfHandlerIsAlreadyTaken signalForHandler: aJRPCHandler ].

	handlersByName
		at: aJRPCHandler methodName put: aJRPCHandler.
]

{ #category : #'handlers management' }
JRPCMessageProcessor >> addHandlerNamed: aString block: aBlock [

	self
		addHandler:
			( JRPCBlockHandler new
				methodName: aString;
				block: aBlock;
				yourself )
]

{ #category : #'handlers management' }
JRPCMessageProcessor >> addHandlersFromPragmasIn: anObject [

	( Pragma allNamed: #jrpc: in: anObject class )
		do: [ :pragma | 
			self
				addHandler:
					( JRPCMessageSendHandler new
						receiver: anObject;
						methodName: pragma arguments first;
						messageSelector: pragma methodSelector;
						yourself )
			]
]

{ #category : #testing }
JRPCMessageProcessor >> canHandleMethodNamed: methodName [

	^ handlersByName includesKey: methodName
]

{ #category : #'handling - jrpc' }
JRPCMessageProcessor >> handleJRPCNotificationObject: aJRPCNotificationObject [
	"A Notification is a Request object without an 'id' member.
	 A Request object that is a Notification signifies the Client's
	 lack of interest in the corresponding Response object, and as
	 such no Response object needs to be returned to the client.
	 The Server MUST NOT reply to a Notification, including those
	 that are within a batch request.

	 Notifications are not confirmable by definition, since they do
	 not have a Response object to be returned. As such, the Client
	 would not be aware of any errors (like e.g. 'Invalid params'
	 'Internal error').
	"
	|response |
	response := self handleJRPCRequestObject: aJRPCNotificationObject.
	
	"In case the request is invalid, an error is returned to the client
	 even though what is described in the above comment.
	 The idea is that, if what was sent by the client is invalid, we are
	 not sure if it was really a notification or if it was a request.
	 Thus, an error is returned.
	"
	(response isError and: [ response isInvalidRequest ])
		ifTrue: [ ^ response ].

	^ JRPCEmptyResponseObject new
]

{ #category : #'handling - jrpc' }
JRPCMessageProcessor >> handleJRPCRequestObject: aJRPCRequestObject [

	^ [ | handler result |

	handler := self handlerForName: aJRPCRequestObject method.
	handler checkParametersForRequest: aJRPCRequestObject.
	result := handler executeWithArguments: aJRPCRequestObject params.
	JRPCSuccessResponseObject id: aJRPCRequestObject id result: result
	]
		on: Error
		do: [ :jrpcError | jrpcError return: ( aJRPCRequestObject convertErrorToResponse: jrpcError ) ]
]

{ #category : #'handling - json' }
JRPCMessageProcessor >> handleJSON: aJSONString [

	"Gets aJSONString as input and returns a JSON string."

	| jrpcResponse |

	jrpcResponse := [ ( self parseSupposedJRPCMessageObjectFromString: aJSONString ) beHandledBy: self ]
		on: Error
		do: [ :error | error return: error asJRPCResponse ].

	^ jrpcResponse beConvertedBy: self
]

{ #category : #accessing }
JRPCMessageProcessor >> handledMethodsCount [

	^ handlersByName size
]

{ #category : #accessing }
JRPCMessageProcessor >> handlerForName: methodName [

	methodName isString
		ifFalse: [ JRPCIncorrectJSON signal ].

	^ handlersByName at: methodName ifAbsent: [ JRPCNonExistentHandler signal: methodName ]
]

{ #category : #initialization }
JRPCMessageProcessor >> initialize [

	super initialize.
	handlersByName := Dictionary new
]

{ #category : #testing }
JRPCMessageProcessor >> isClient [

	^ false
]

{ #category : #'handlers management' }
JRPCMessageProcessor >> removeHandlerNamed: aString [

	handlersByName removeKey: aString ifAbsent: [ self error: 'Inexistant handler.' ]
]
