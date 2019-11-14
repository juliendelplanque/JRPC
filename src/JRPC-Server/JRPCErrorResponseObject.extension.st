Extension { #name : #JRPCErrorResponseObject }

{ #category : #'*JRPC-Server' }
JRPCErrorResponseObject >> beHandledBy: aJRPCMessageProcessor [

	"Returns self, this method is executed when a request inside a batch generated an error."

	^ self
]
