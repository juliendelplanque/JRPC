"
I am a handler that look in receiver class for a method with <jrpc> pragma.

This method is executed when the handler is executed.

If no method or multiple methods have <jrpc> pragma, an error is raised.
"
Class {
	#name : #JRPCPragmaHandler,
	#superclass : #JRPCMessageSendHandler,
	#category : #'JRPC-Server-Core-JRPC-Server-Core'
}

{ #category : #private }
JRPCPragmaHandler >> getMethodSelectorFromPragma [
	"Returns the selector corresponding to the method to execute as behaviour of the handler.
	 This method is retrieved by searching for <jrpc> pragma.
	"
	| pragmas |
	pragmas := (Pragma allNamed: #jrpc in: self receiver class).
	
	pragmas size = 1
		ifFalse: [ self error: 'Only one method should be tagged with <jrpc> pragma.' ].
		
	^ pragmas first methodSelector
]

{ #category : #initialization }
JRPCPragmaHandler >> initialize [
	super initialize.
	self receiver: self.
	self messageSelector: self getMethodSelectorFromPragma
]
