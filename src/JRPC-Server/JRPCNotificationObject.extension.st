Extension { #name : #JRPCNotificationObject }

{ #category : #'*JRPC-Server' }
JRPCNotificationObject >> beHandledByServer: aJRPCServer [
	^ aJRPCServer handleJRPCNotificationObject: self
]

{ #category : #'*JRPC-Server' }
JRPCNotificationObject >> convertErrorToResponse: jrpcError [
	jrpcError isIncorrectJSON
		ifTrue: [ ^ jrpcError asJRPCResponseWithId: self id ].
	
	^ JRPCEmptyResponseObject new
]
