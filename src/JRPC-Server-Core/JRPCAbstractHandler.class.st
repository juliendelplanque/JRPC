"
I am an abstract handler that deal with JRPC request for the #methodName I have.

I define the common API expected from any handler.

My concrete subclasses must override #executeWithArguments: method to define what they do and #parametersNames returns the name of the parameters I expect.

I also know the #server to which I have been added (if any).
"
Class {
	#name : #JRPCAbstractHandler,
	#superclass : #Object,
	#instVars : [
		'methodName',
		'isForNotification',
		'isForRequest'
	],
	#category : #'JRPC-Server-Core'
}

{ #category : #accessing }
JRPCAbstractHandler class >> defaultMethodName [
	"Returns the method name that will be set to the handler instance by default."
	^ self subclassResponsibility
]

{ #category : #testing }
JRPCAbstractHandler >> canHandle: aRequestOrNotification [
	^ (self isForRequest and: [ aRequestOrNotification isRequest ])
		or: [ self isForNotification and: [ aRequestOrNotification isNotification ] ]
]

{ #category : #'parameters-checking' }
JRPCAbstractHandler >> checkParametersForRequest: aJRPCRequestObject [
	aJRPCRequestObject params
		ifNil: [ 
			self parametersCount = 0
				ifFalse: [ JRPCInvalidParameters signal ] ].
	
	(aJRPCRequestObject params ifNil: [ #() ]) size = self parametersCount
		ifFalse: [ JRPCInvalidParameters signal ].
		
	(aJRPCRequestObject params isDictionary
		and: [ ((aJRPCRequestObject params keys union: self parametersNames) size ~= self parametersCount) ])
			ifTrue: [ JRPCInvalidParameters signal ]
]

{ #category : #accessing }
JRPCAbstractHandler >> defaultMethodName [
	^ self class defaultMethodName
]

{ #category : #evaluation }
JRPCAbstractHandler >> executeWithArguments: anArrayOrDictionary [
	^ self subclassResponsibility
]

{ #category : #initialization }
JRPCAbstractHandler >> initialize [
	super initialize.
	self isForRequest: true.
	self isForNotification: true
]

{ #category : #accessing }
JRPCAbstractHandler >> isForNotification [
	^ isForNotification
]

{ #category : #accessing }
JRPCAbstractHandler >> isForNotification: aBoolean [
	(aBoolean not and: [ self isForRequest not ])
		ifTrue: [ self error: 'A handler must be for notification or for request. It can not refuse both!' ].
		
	isForNotification := aBoolean
]

{ #category : #accessing }
JRPCAbstractHandler >> isForRequest [
	^ isForRequest
]

{ #category : #accessing }
JRPCAbstractHandler >> isForRequest: aBoolean [
	(aBoolean not and: [ self isForNotification not ])
		ifTrue: [ self error: 'A handler must be for notification or for request. It can not refuse both!' ].
	
	isForRequest := aBoolean
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
