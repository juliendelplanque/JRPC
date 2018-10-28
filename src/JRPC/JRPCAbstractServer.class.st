Class {
	#name : #JRPCAbstractServer,
	#superclass : #Object,
	#traits : 'JRPCParser',
	#classTraits : 'JRPCParser classTrait',
	#instVars : [
		'namesToHandlersDict'
	],
	#category : #'JRPC-Servers'
}

{ #category : #adding }
JRPCAbstractServer >> addHandlerNamed: aString block: aBlock [
	namesToHandlersDict
		at: aString put: aBlock
]

{ #category : #checking }
JRPCAbstractServer >> checkParamsMatchingForHandler: handler andRequest: aJRPCRequestObject [
	aJRPCRequestObject params
		ifNil: [ 
			handler jrpcParametersCount = 0
				ifFalse: [ JRPCInvalidParameters signal ] ].
	
	aJRPCRequestObject params size = handler jrpcParametersCount
		ifFalse: [ JRPCInvalidParameters signal ].
		
	(aJRPCRequestObject params isDictionary
		and: [ ((aJRPCRequestObject params keys union: handler jrpcParametersNames) size ~= handler jrpcParametersCount) ])
			ifTrue: [ JRPCInvalidParameters signal ]
]

{ #category : #'handling - jrpc' }
JRPCAbstractServer >> handleJRPCRequestObject: aJRPCRequestObject [
	[ | handler result |
		handler := self handlerForName: aJRPCRequestObject method.
		self checkParamsMatchingForHandler: handler andRequest: aJRPCRequestObject.
		result := handler jrpcExecuteWithParameters: aJRPCRequestObject params.
		^ JRPCSuccessResponseObject id: aJRPCRequestObject id result: result
	] on: JRPCError
	do: [ :jrpcError |
		^ jrpcError asJRPCResponseWithId: aJRPCRequestObject id ]
]

{ #category : #accessing }
JRPCAbstractServer >> handlerForName: aString [
	^ namesToHandlersDict
		at: aString
		ifAbsent: [ 
			JRPCNonExistentHandler new
				handlerName: aString;
				signal: aString ]
]

{ #category : #initialization }
JRPCAbstractServer >> initialize [
	super initialize.
	namesToHandlersDict := Dictionary new
]

{ #category : #starting }
JRPCAbstractServer >> start [
	"Starts the server.
	 Depends on the transport implementation, to be overrided by subclasses.
	"
	self subclassResponsibility
]

{ #category : #stopping }
JRPCAbstractServer >> stop [
	"Stops the server.
	 Depends on the transport implementation, to be overrided by subclasses.
	"
	self subclassResponsibility
]
