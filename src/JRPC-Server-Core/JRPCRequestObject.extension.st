Extension { #name : #JRPCRequestObject }

{ #category : #'*JRPC-Server-Core' }
JRPCRequestObject >> beHandledBy: aJRPCMessageProcessor [

	^ aJRPCMessageProcessor handleJRPCRequestObject: self
]

{ #category : #'*JRPC-Server-Core' }
JRPCRequestObject >> convertErrorToResponse: jrpcError [
	^ jrpcError asJRPCResponseWithId: self id
]
