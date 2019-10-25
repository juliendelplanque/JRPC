"
I am a handler for which the execution is defined by my #block.

My #executeWithArguments: method just delegate the execution to my #block inst. var.
"
Class {
	#name : #JRPCBlockHandler,
	#superclass : #JRPCHandler,
	#instVars : [
		'block'
	],
	#category : #'JRPC-Server'
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
	^ block
]

{ #category : #accessing }
JRPCBlockHandler >> block: anObject [
	block := anObject
]

{ #category : #evaluation }
JRPCBlockHandler >> executeWithArguments: anArrayOrDictionary [
	| arguments |
	anArrayOrDictionary ifNil: [ 
		^ self block value ].
	anArrayOrDictionary isArray
		ifTrue: [ ^ self block valueWithArguments: anArrayOrDictionary ].
		
	arguments := (anArrayOrDictionary associations sorted: [ :a :b |
		(self parametersNames indexOf: a key) < (self parametersNames indexOf: b key) ])
			collect: #value.
	
	^ self block valueWithArguments: arguments
]

{ #category : #accessing }
JRPCBlockHandler >> parametersNames [
	"Returns the names of the parameters expected by the handler as a collection."
	^ self block argumentNames
]
