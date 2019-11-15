Extension { #name : #JRPCRequestObject }

{ #category : #'*JRPC-Server' }
JRPCRequestObject >> beHandledBy: aJRPCMessageProcessor [

	^ aJRPCMessageProcessor handleJRPCRequestObject: self
]

{ #category : #'*JRPC-Server' }
JRPCRequestObject >> convertErrorToResponse: jrpcError [
	^ jrpcError asJRPCResponseWithId: self id
]
