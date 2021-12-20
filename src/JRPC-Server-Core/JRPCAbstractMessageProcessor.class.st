"
I declare the minimal API expected from a message processor.

My concrete subclasses should implement all my abstract methods.
"
Class {
	#name : #JRPCAbstractMessageProcessor,
	#superclass : #Object,
	#category : #'JRPC-Server-Core'
}

{ #category : #'handlers management' }
JRPCAbstractMessageProcessor >> addErrorHandler: aBlock [

	self subclassResponsibility
]

{ #category : #'handlers management' }
JRPCAbstractMessageProcessor >> addHandler: aJRPCHandler [
	"Adds aJRPCHandler to the list of available handlers."
	self subclassResponsibility
]

{ #category : #'handlers management' }
JRPCAbstractMessageProcessor >> addHandlerNamed: aString block: aBlock [

	self
		addHandler:
			( JRPCBlockHandler new
				methodName: aString;
				block: aBlock;
				yourself )
]

{ #category : #'handlers management' }
JRPCAbstractMessageProcessor >> addHandlersFromPragmasIn: anObject [

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

{ #category : #'handling - json' }
JRPCAbstractMessageProcessor >> debugMode [
	^ self subclassResponsibility
]

{ #category : #'handling - json' }
JRPCAbstractMessageProcessor >> debugMode: aBoolean [
	^ self subclassResponsibility
]

{ #category : #'handling - json' }
JRPCAbstractMessageProcessor >> handleJSON: aJSONString [
	"Gets aJSONString being a request or notification serialized in JSON format as input
	 and returns a JSON string being the answer serialized in JSON format.
	"
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractMessageProcessor >> handlers [
	"Returns the collection of handlers managed by myself."
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractMessageProcessor >> handlersCount [
	"Returns the number of handlers managed by myself."
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractMessageProcessor >> handlersDetect: aBlock [
	^ self handlers detect: aBlock
]

{ #category : #testing }
JRPCAbstractMessageProcessor >> isLogger [
	^ false
]

{ #category : #'handlers management' }
JRPCAbstractMessageProcessor >> removeHandler: aJRPCHandler [
	"Removes aJRPCHandler from the collection of managed handlers."
	self subclassResponsibility
]
