"
I am the error raised when an attempt to add an handler equals to another handler already added to the message processor is made.
"
Class {
	#name : #JRPCDuplicatedHandlerError,
	#superclass : #Error,
	#instVars : [
		'handler'
	],
	#category : #'JRPC-Server-Core'
}

{ #category : #'instance creation' }
JRPCDuplicatedHandlerError class >> signalForHandler: handler [
	^ self new
		handler: handler;
		signal
]

{ #category : #accessing }
JRPCDuplicatedHandlerError >> handler [
	^ handler
]

{ #category : #accessing }
JRPCDuplicatedHandlerError >> handler: anObject [
	handler := anObject
]
