"
I am an abstract handler that deal with JRPC request for the #methodName I have.

My concrete subclasses must override #executeWithArguments: method to define what they do.

I also know the #server to which I have been added (if any).
"
Class {
	#name : #JRPCHandler,
	#superclass : #Object,
	#instVars : [
		'methodName',
		'server'
	],
	#category : #'JRPC-Server'
}

{ #category : #evaluation }
JRPCHandler >> executeWithArguments: anArrayOrDictionary [
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCHandler >> methodName [
	^ methodName
]

{ #category : #accessing }
JRPCHandler >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
JRPCHandler >> parametersCount [
	"Returns the number of parameters expected by the handler."
	^ self parametersNames size
]

{ #category : #accessing }
JRPCHandler >> parametersNames [
	"Returns the names of the parameters expected by the handler as a collection."
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCHandler >> server [
	^ server
]

{ #category : #accessing }
JRPCHandler >> server: anObject [
	server := anObject
]
