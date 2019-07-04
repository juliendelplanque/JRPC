"
I am an error raised when the handler required does not exist.
"
Class {
	#name : #JRPCNonExistentHandler,
	#superclass : #JRPCError,
	#category : #'JRPC-Server'
}

{ #category : #converting }
JRPCNonExistentHandler >> asJRPCResponseWithId: anInteger [
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject methodNotFound
]
