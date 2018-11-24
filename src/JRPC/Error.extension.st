Extension { #name : #Error }

{ #category : #'*JRPC' }
Error >> asJRPCResponse [
	^ self asJRPCResponseWithId: nil
]

{ #category : #'*JRPC' }
Error >> asJRPCResponseWithId: anInteger [
	^ JRPCErrorResponseObject id: anInteger error: JRPCErrorObject internalError
]
