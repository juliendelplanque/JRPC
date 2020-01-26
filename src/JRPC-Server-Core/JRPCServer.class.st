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
	#category : #'JRPC-Server-Core'
}

{ #category : #'handlers management' }
JRPCServer >> addHandler: aJRPCHandler [

	self messageProcessor addHandler: aJRPCHandler
]

{ #category : #'handlers management' }
JRPCServer >> addHandlerNamed: aString block: aBlock [

	self messageProcessor addHandlerNamed: aString block: aBlock
]

{ #category : #'handlers management' }
JRPCServer >> addHandlersFromPragmasIn: anObject [

	self messageProcessor addHandlersFromPragmasIn: anObject
]

{ #category : #accessing }
JRPCServer >> debugMode [
	^ self messageProcessor debugMode
]

{ #category : #accessing }
JRPCServer >> debugMode: aBoolean [
	^ self messageProcessor debugMode: aBoolean
]

{ #category : #'handling - jrpc' }
JRPCServer >> handleJRPCRequestObject: aJRPCRequestObject [

	^ self messageProcessor handleJRPCRequestObject: aJRPCRequestObject
]

{ #category : #'handling - json' }
JRPCServer >> handleJSON: aJSONString [

	^ self messageProcessor handleJSON: aJSONString
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

	self messageProcessor removeHandlerNamed: aString
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
