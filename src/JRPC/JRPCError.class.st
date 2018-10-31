"
I am an abstract error that can be created by JRPC framework.
"
Class {
	#name : #JRPCError,
	#superclass : #Error,
	#category : #'JRPC-Errors'
}

{ #category : #converting }
JRPCError >> asJRPCResponse [
	"Create a JRPCResponse with id set to nil.
	 That is to say, this is an error for which one can not know from which request it is originated."
	^ self asJRPCResponseWithId: nil
]

{ #category : #converting }
JRPCError >> asJRPCResponseWithId: anInteger [
	"Convert the error to a JRPCErrorObject.
	 To be overrided by subclasses."
	^ self subclassResponsibility
]
