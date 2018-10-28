Class {
	#name : #JRPCInvalidParameters,
	#superclass : #JRPCError,
	#category : #'JRPC-Errors'
}

{ #category : #converting }
JRPCInvalidParameters >> asJRPCResponseWithId: anInteger [ 
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject invalidParams
]
