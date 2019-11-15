"
I am a handler for which the execution is defined by my #block.

My #executeWithArguments: method just delegate the execution to my #block inst. var.
"
Class {
	#name : #JRPCBlockHandler,
	#superclass : #JRPCMessageSendHandler,
	#instVars : [
		'block'
	],
	#category : #'JRPC-Server-Core-JRPC-Server-Core'
}

{ #category : #accessing }
JRPCBlockHandler class >> defaultMethodName [
	"If this method is called, it means that the user did not set the #methodName of the block handler.
	 It is mandatory to do it.
	"
	^ self error: 'It is mandatory to specify the #methodName of a block handler via #methodName: method on instance side.'
]

{ #category : #'instance creation' }
JRPCBlockHandler class >> methodName: methodName block: block [
	"Creates a new handler with the specified methodName and the execution specificied by the #block."
	^ self new
		methodName: methodName;
		block: block;
		yourself
]

{ #category : #accessing }
JRPCBlockHandler >> block [
	^ self receiver
]

{ #category : #accessing }
JRPCBlockHandler >> block: anObject [
	self receiver: anObject
]

{ #category : #accessing }
JRPCBlockHandler >> messageSelector [
	^ #valueWithArguments:
]

{ #category : #accessing }
JRPCBlockHandler >> messageSelector: anObject [
	self error: 'Can not set the message selector manually, this is deteminated depending on the #block to execute.'
]

{ #category : #accessing }
JRPCBlockHandler >> parametersNames [
	"Returns the names of the parameters expected by the handler as a collection."
	^ self block argumentNames
]

{ #category : #private }
JRPCBlockHandler >> send: aSelector to: aBlock with: arguments [
	^ super send: aSelector to: aBlock with: (Array with: arguments)
]
