"
I am the implementation of the decorator design pattern for a message processor.

I allow one to perform actions before/after a message is processed by my #decoratedMessageProcessor.

By default, I do nothing. My subclasses must be more interesting.
"
Class {
	#name : #JRPCMessageProcessorDecorator,
	#superclass : #JRPCAbstractMessageProcessor,
	#instVars : [
		'decoratedMessageProcessor'
	],
	#category : #'JRPC-Server-Core'
}

{ #category : #accessing }
JRPCMessageProcessorDecorator class >> decorate: aMessageProcessor [
	^ self new
		decoratedMessageProcessor: aMessageProcessor;
		yourself
]

{ #category : #adding }
JRPCMessageProcessorDecorator >> addErrorHandler: aBlock [

	self decoratedMessageProcessor addErrorHandler: aBlock
]

{ #category : #adding }
JRPCMessageProcessorDecorator >> addHandler: aJRPCHandler [
	self decoratedMessageProcessor addHandler: aJRPCHandler
]

{ #category : #'handling - json' }
JRPCMessageProcessorDecorator >> debugMode [
	^ self decoratedMessageProcessor debugMode
]

{ #category : #'handling - json' }
JRPCMessageProcessorDecorator >> debugMode: aBoolean [
	^ self decoratedMessageProcessor debugMode: aBoolean
]

{ #category : #accessing }
JRPCMessageProcessorDecorator >> decoratedMessageProcessor [
	^ decoratedMessageProcessor
]

{ #category : #accessing }
JRPCMessageProcessorDecorator >> decoratedMessageProcessor: anObject [
	decoratedMessageProcessor := anObject
]

{ #category : #'handling - json' }
JRPCMessageProcessorDecorator >> handleJSON: aJSONString [
	"Gets aJSONString being a request or notification serialized in JSON format as input
	 and returns a JSON string being the answer serialized in JSON format.
	"
	^ self decoratedMessageProcessor handleJSON: aJSONString
]

{ #category : #accessing }
JRPCMessageProcessorDecorator >> handlers [
	^ self decoratedMessageProcessor handlers
]

{ #category : #accessing }
JRPCMessageProcessorDecorator >> handlersCount [
	^ self decoratedMessageProcessor handlersCount
]

{ #category : #'handlers management' }
JRPCMessageProcessorDecorator >> removeHandler: aJRPCHandler [
	self decoratedMessageProcessor removeHandler: aJRPCHandler
]

{ #category : #removing }
JRPCMessageProcessorDecorator >> removeHandlerNamed: aString [
	^ self decoratedMessageProcessor removeHandlerNamed: aString
]
