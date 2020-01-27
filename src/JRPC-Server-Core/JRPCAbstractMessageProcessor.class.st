"
I declare the minimal API expected from a message processor.

My concrete subclasses should implement all my abstract methods.
"
Class {
	#name : #JRPCAbstractMessageProcessor,
	#superclass : #Object,
	#category : #'JRPC-Server-Core'
}

{ #category : #adding }
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

{ #category : #testing }
JRPCAbstractMessageProcessor >> canHandleMethodNamed: methodName [
	"Returns true if the message processor can handle the method named methodName.
	 Else returns false.
	"
	^ self subclassResponsibility
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
JRPCAbstractMessageProcessor >> handledMethodsCount [
	"Returns the number of handled methods."
	^ self subclassResponsibility
]

{ #category : #testing }
JRPCAbstractMessageProcessor >> isLogger [
	^ false
]
