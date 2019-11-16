Extension { #name : #JRPCBatchRequestsObject }

{ #category : #'*JRPC-Server-Core' }
JRPCBatchRequestsObject >> beHandledBy: aJRPCMessageProcessor [

	^ JRPCBatchResponseObject new
		responses: ( self requests collect: [ :req | req beHandledBy: aJRPCMessageProcessor ] );
		yourself
]
