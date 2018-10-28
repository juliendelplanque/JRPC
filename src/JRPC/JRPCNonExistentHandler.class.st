"
I am an error raised when the handler required does not exist.
"
Class {
	#name : #JRPCNonExistentHandler,
	#superclass : #JRPCError,
	#instVars : [
		'handlerName'
	],
	#category : #'JRPC-Errors'
}

{ #category : #converting }
JRPCNonExistentHandler >> asJRPCResponseWithId: anInteger [
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject methodNotFound
]

{ #category : #accessing }
JRPCNonExistentHandler >> handlerName [
	^ handlerName
]

{ #category : #accessing }
JRPCNonExistentHandler >> handlerName: anObject [
	handlerName := anObject
]
