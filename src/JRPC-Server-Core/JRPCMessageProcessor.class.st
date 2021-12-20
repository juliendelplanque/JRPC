"
I am capable of processing JSON-RPC 2.0 messages.

To configure me you can use one of the messages in the 'handlers management' protocol.

A JSON RPC server must solve the specific transport details and handle to me the processing of any incoming message.
"
Class {
	#name : #JRPCMessageProcessor,
	#superclass : #JRPCAbstractMessageProcessor,
	#traits : 'JRPCParser',
	#classTraits : 'JRPCParser classTrait',
	#instVars : [
		'handlers',
		'debugMode',
		'errorHandlers'
	],
	#category : #'JRPC-Server-Core'
}

{ #category : #'handlers management' }
JRPCMessageProcessor >> addErrorHandler: aBlock [

	errorHandlers add: aBlock
]

{ #category : #'handlers management' }
JRPCMessageProcessor >> addHandler: aJRPCHandler [

	(self handlers includes: aJRPCHandler)
		ifTrue: [ JRPCDuplicatedHandlerError signalForHandler: aJRPCHandler ].

	handlers add: aJRPCHandler
]

{ #category : #accessing }
JRPCMessageProcessor >> debugMode [
	^ debugMode
]

{ #category : #accessing }
JRPCMessageProcessor >> debugMode: aBoolean [
	debugMode := aBoolean
]

{ #category : #private }
JRPCMessageProcessor >> handleErrorsDuring: aBlock for: aJRPCRequestObject [

	^ self debugMode
		  ifTrue: aBlock
		  ifFalse: [ 
			  aBlock
				  on: Error
				  do: [ :jrpcError | 
					  errorHandlers do: [ :handler | handler cull: jrpcError ].
					  jrpcError return:
						  (aJRPCRequestObject convertErrorToResponse: jrpcError) ] ]
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

	^ self
		  handleErrorsDuring: [ 
			  | handler result |
			  handler := self handlerFor: aJRPCRequestObject.
			  handler checkParametersForRequest: aJRPCRequestObject.
			  result := handler executeWithArguments: aJRPCRequestObject params.
			  JRPCSuccessResponseObject
				  id: aJRPCRequestObject id
				  result: result ]
		  for: aJRPCRequestObject
]

{ #category : #'handling - json' }
JRPCMessageProcessor >> handleJSON: aJSONString [
	"Gets aJSONString being a request or notification serialized in JSON format as input
	 and returns a JSON string being the answer serialized in JSON format.
	"

	| jrpcResponse |

	jrpcResponse := [ ( self parseSupposedJRPCMessageObjectFromString: aJSONString ) beHandledBy: self ]
		on: Error
		do: [ :error | 
			self debugMode
				ifTrue: [ error pass ]
				ifFalse: [ error return: error asJRPCResponse ] ].

	^ jrpcResponse beConvertedBy: self
]

{ #category : #accessing }
JRPCMessageProcessor >> handlerFor: requestOrNotification [
	requestOrNotification method isString
		ifFalse: [ JRPCIncorrectJSON signal ].

	^ handlers
		detect: [ :handler | 
			handler methodName = requestOrNotification method
				and: [ handler canHandle: requestOrNotification ] ]
		ifNone: [ JRPCNonExistentHandler signal: requestOrNotification method ]
]

{ #category : #'handlers management' }
JRPCMessageProcessor >> handlers [
	^ handlers
]

{ #category : #accessing }
JRPCMessageProcessor >> handlersCount [

	^ handlers size
]

{ #category : #initialization }
JRPCMessageProcessor >> initialize [

	super initialize.
	handlers := OrderedCollection new.
	errorHandlers := OrderedCollection new.
	self debugMode: false
]

{ #category : #testing }
JRPCMessageProcessor >> isClient [

	^ false
]

{ #category : #'handlers management' }
JRPCMessageProcessor >> removeHandler: aJRPCHandler [
	handlers remove: aJRPCHandler
]
