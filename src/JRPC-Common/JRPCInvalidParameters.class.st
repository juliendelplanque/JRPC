"
I am an error raised when the parameters of the method called are invalid.
"
Class {
	#name : #JRPCInvalidParameters,
	#superclass : #JRPCError,
	#category : #'JRPC-Common-Errors'
}

{ #category : #converting }
JRPCInvalidParameters >> asJRPCResponseWithId: anInteger [ 
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject invalidParams
]
