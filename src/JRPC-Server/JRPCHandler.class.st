Class {
	#name : #JRPCHandler,
	#superclass : #JRPCMessageSendHandler,
	#category : #'JRPC-Server'
}

{ #category : #initialization }
JRPCHandler >> initialize [
	super initialize.
	self receiver: self.
	self messageSelector: self selectorOfMethodToExecute
]

{ #category : #accessing }
JRPCHandler >> selectorOfMethodToExecute [
	"Returns the selector corresponding to the method to execute as behaviour of the handler."
	| pragmas |
	pragmas := (Pragma allNamed: #jrpc in: self receiver class).
	
	pragmas size = 1
		ifFalse: [ self error: 'More than one method is tagged with <jrpc> pragma.' ].
		
	^ pragmas first methodSelector
]
