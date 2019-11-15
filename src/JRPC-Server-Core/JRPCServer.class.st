"
I am an abstract server for JSON-RPC 2.0.
My subclasses define how to handle JSON-RPC objects coming from a client resolving 
the transport specific details and delegating later to the messageProcessor the processing
of the incoming message.
"
Class {
	#name : #JRPCServer,
	#superclass : #Object,
	#instVars : [
		'messageProcessor'
	],
	#category : #'JRPC-Server-Core-JRPC-Server-Core'
}

{ #category : #'handlers management' }
JRPCServer >> addHandler: aJRPCHandler [

	messageProcessor addHandler: aJRPCHandler
]

{ #category : #'handlers management' }
JRPCServer >> addHandlerNamed: aString block: aBlock [

	messageProcessor addHandlerNamed: aString block: aBlock
]

{ #category : #'handlers management' }
JRPCServer >> addHandlersFromPragmasIn: anObject [

	messageProcessor addHandlersFromPragmasIn: anObject
]

{ #category : #'handling - jrpc' }
JRPCServer >> handleJRPCRequestObject: aJRPCRequestObject [

	^ messageProcessor handleJRPCRequestObject: aJRPCRequestObject
]

{ #category : #'handling - json' }
JRPCServer >> handleJSON: aJSONString [

	^ messageProcessor handleJSON: aJSONString
]

{ #category : #initialization }
JRPCServer >> initialize [

	super initialize.
	messageProcessor := JRPCMessageProcessor new
]

{ #category : #accessing }
JRPCServer >> messageProcessor [

	^ messageProcessor
]

{ #category : #'handlers management' }
JRPCServer >> removeHandlerNamed: aString [

	messageProcessor removeHandlerNamed: aString
]

{ #category : #starting }
JRPCServer >> start [
	"Starts the server.
	 Depends on the transport implementation, to be overrided by subclasses.
	"
	self subclassResponsibility
]

{ #category : #stopping }
JRPCServer >> stop [
	"Stops the server.
	 Depends on the transport implementation, to be overrided by subclasses.
	"
	self subclassResponsibility
]
