Extension { #name : #JRPCNotificationObject }

{ #category : #'*JRPC-Server' }
JRPCNotificationObject >> beHandledBy: aJRPCMessageProcessor [

	^ aJRPCMessageProcessor handleJRPCNotificationObject: self
]

{ #category : #'*JRPC-Server' }
JRPCNotificationObject >> convertErrorToResponse: jrpcError [
	jrpcError isIncorrectJSON
		ifTrue: [ ^ jrpcError asJRPCResponseWithId: self id ].
	
	^ JRPCEmptyResponseObject new
]
