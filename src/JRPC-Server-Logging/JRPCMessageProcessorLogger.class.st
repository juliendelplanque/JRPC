"
I log incoming/outgoing JSON read/answered by a message processor as communication log objects in the collection my #logs instance variable hold.

I am quite interesting in case one wants to understand what happens during communication without interfering with it.
"
Class {
	#name : #JRPCMessageProcessorLogger,
	#superclass : #JRPCMessageProcessorDecorator,
	#instVars : [
		'logs'
	],
	#category : #'JRPC-Server-Logging'
}

{ #category : #'handling - json' }
JRPCMessageProcessorLogger >> handleJSON: aJSONString [
	| answerJSON |
	answerJSON := super handleJSON: aJSONString.
	self logs add: (JRPCCommunicationLog incomingJSON: aJSONString answerJSON: answerJSON) timestampBeNow.
	^ answerJSON
]

{ #category : #initialization }
JRPCMessageProcessorLogger >> initialize [
	super initialize.
	self logs: OrderedCollection new
]

{ #category : #testing }
JRPCMessageProcessorLogger >> isLogger [
	^ true
]

{ #category : #accessing }
JRPCMessageProcessorLogger >> logs [
	^ logs
]

{ #category : #accessing }
JRPCMessageProcessorLogger >> logs: anObject [
	logs := anObject
]
