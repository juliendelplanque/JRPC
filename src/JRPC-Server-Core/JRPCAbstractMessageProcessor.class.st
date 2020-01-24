"
I declare the minimal API expected from a message processor.

My concrete subclasses should implement all my abstract methods.
"
Class {
	#name : #JRPCAbstractMessageProcessor,
	#superclass : #Object,
	#category : #'JRPC-Server-Core'
}

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

{ #category : #testing }
JRPCAbstractMessageProcessor >> isLogger [
	^ false
]
