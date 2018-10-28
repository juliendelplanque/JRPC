"
I am an error raised when incorrect JSON was encountered during processing.

By Incorrect, I do not mean that the JSON is malformed.

I mean that its key/values are not what is expected.
"
Class {
	#name : #JRPCIncorrectJSON,
	#superclass : #JRPCError,
	#category : #'JRPC-Errors'
}

{ #category : #converting }
JRPCIncorrectJSON >> asJRPCResponseWithId: anInteger [
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject invalidRequest
]
