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
