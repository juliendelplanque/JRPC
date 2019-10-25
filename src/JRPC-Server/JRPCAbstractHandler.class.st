"
I am an abstract handler that deal with JRPC request for the #methodName I have.

My concrete subclasses must override #executeWithArguments: method to define what they do.

I also know the #server to which I have been added (if any).
"
Class {
	#name : #JRPCAbstractHandler,
	#superclass : #Object,
	#instVars : [
		'methodName',
		'server'
	],
	#category : #'JRPC-Server'
}

{ #category : #accessing }
JRPCAbstractHandler class >> defaultMethodName [
	"Returns the method name that will be set to the handler instance by default."
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractHandler >> defaultMethodName [
	^ self class defaultMethodName
]

{ #category : #evaluation }
JRPCAbstractHandler >> executeWithArguments: anArrayOrDictionary [
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractHandler >> methodName [
	^ methodName ifNil: [ methodName := self defaultMethodName ]
]

{ #category : #accessing }
JRPCAbstractHandler >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
JRPCAbstractHandler >> parametersCount [
	"Returns the number of parameters expected by the handler."
	^ self parametersNames size
]

{ #category : #accessing }
JRPCAbstractHandler >> parametersNames [
	"Returns the names of the parameters expected by the handler as a collection."
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractHandler >> server [
	^ server
]

{ #category : #accessing }
JRPCAbstractHandler >> server: anObject [
	server := anObject
]
