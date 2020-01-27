"
I am an error raised when the request sent to the server is invalid.
"
Class {
	#name : #JRPCInvalidRequest,
	#superclass : #JRPCError,
	#category : #'JRPC-Server-Core'
}

{ #category : #converting }
JRPCInvalidRequest >> asJRPCResponseWithId: anInteger [ 
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject invalidRequest
]
