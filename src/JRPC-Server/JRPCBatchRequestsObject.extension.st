Extension { #name : #JRPCBatchRequestsObject }

{ #category : #'*JRPC-Server' }
JRPCBatchRequestsObject >> beHandledBy: aJRPCMessageProcessor [

	^ JRPCBatchResponseObject new
		responses: ( self requests collect: [ :req | req beHandledBy: aJRPCMessageProcessor ] );
		yourself
]
