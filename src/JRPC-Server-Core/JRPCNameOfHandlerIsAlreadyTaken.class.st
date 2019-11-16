"
I am the error raised when an attempt to add an handler with the same name as another handler already added to the server is made.
"
Class {
	#name : #JRPCNameOfHandlerIsAlreadyTaken,
	#superclass : #Error,
	#instVars : [
		'handler'
	],
	#category : #'JRPC-Server-Core'
}

{ #category : #'instance creation' }
JRPCNameOfHandlerIsAlreadyTaken class >> signalForHandler: handler [
	^ self new
		handler: handler;
		signal
]

{ #category : #accessing }
JRPCNameOfHandlerIsAlreadyTaken >> handler [
	^ handler
]

{ #category : #accessing }
JRPCNameOfHandlerIsAlreadyTaken >> handler: anObject [
	handler := anObject
]
