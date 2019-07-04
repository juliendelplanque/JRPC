Extension { #name : #JRPCRequestObject }

{ #category : #'*JRPC-Server' }
JRPCRequestObject >> beHandledByServer: aJRPCServer [
	^ aJRPCServer handleJRPCRequestObject: self
]

{ #category : #'*JRPC-Server' }
JRPCRequestObject >> convertErrorToResponse: jrpcError [
	^ jrpcError asJRPCResponseWithId: self id
]
