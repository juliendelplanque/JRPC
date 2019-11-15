"
I am an handler that, when executed, sends the message with selector #messageSelector to the #receiver.

For example,

JRPCMessageSendHandler new
	methodName: 'plus';
	messageSelector: #+;
	receiver: 1;
	yourself
	
Will the send #+ message to the instance of SmallInteger 1 with the arguments provided.
"
Class {
	#name : #JRPCMessageSendHandler,
	#superclass : #JRPCAbstractHandler,
	#instVars : [
		'receiver',
		'messageSelector'
	],
	#category : #'JRPC-Server-Core-JRPC-Server-Core'
}

{ #category : #evaluation }
JRPCMessageSendHandler >> executeWithArguments: anArrayOrDictionary [
	| arguments |
	arguments := anArrayOrDictionary.
	
	anArrayOrDictionary ifNil: [ 
		arguments := #() ].
	
	anArrayOrDictionary isDictionary
		ifTrue: [
			arguments := (anArrayOrDictionary associations sorted: [ :a :b |
				(self parametersNames indexOf: a key) < (self parametersNames indexOf: b key) ])
					collect: #value ].
		
	^ self send: self messageSelector to: self receiver with: arguments
]

{ #category : #accessing }
JRPCMessageSendHandler >> messageSelector [
	^ messageSelector
]

{ #category : #accessing }
JRPCMessageSendHandler >> messageSelector: anObject [
	messageSelector := anObject
]

{ #category : #accessing }
JRPCMessageSendHandler >> parametersNames [
	^ (self receiver class >> self messageSelector) argumentNames
]

{ #category : #accessing }
JRPCMessageSendHandler >> receiver [
	^ receiver
]

{ #category : #accessing }
JRPCMessageSendHandler >> receiver: anObject [
	receiver := anObject
]

{ #category : #private }
JRPCMessageSendHandler >> send: aSelector to: aReceiver with: arguments [
	^ aReceiver perform: aSelector withArguments: arguments
]
