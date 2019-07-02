Extension { #name : #JRPCErrorResponseObject }

{ #category : #'*JRPC-Server' }
JRPCErrorResponseObject >> beHandledByServer: aJRPCServer [
	"Returns self, this method is executed when a request inside a batch generated an error."
	^ self
]
