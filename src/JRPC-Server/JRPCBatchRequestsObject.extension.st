Extension { #name : #JRPCBatchRequestsObject }

{ #category : #'*JRPC-Server' }
JRPCBatchRequestsObject >> beHandledByServer: aJRPCServer [
	^ JRPCBatchResponseObject new
		responses: (self requests collect: [ :req |
						req beHandledByServer: aJRPCServer ]);
		yourself
]
