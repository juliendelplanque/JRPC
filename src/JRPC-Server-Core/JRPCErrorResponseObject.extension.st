Extension { #name : #JRPCErrorResponseObject }

{ #category : #'*JRPC-Server-Core' }
JRPCErrorResponseObject >> beHandledBy: aJRPCMessageProcessor [

	"Returns self, this method is executed when a request inside a batch generated an error."

	^ self
]
