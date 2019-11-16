Extension { #name : #JRPCNotificationObject }

{ #category : #'*JRPC-Server-Core' }
JRPCNotificationObject >> beHandledBy: aJRPCMessageProcessor [

	^ aJRPCMessageProcessor handleJRPCNotificationObject: self
]

{ #category : #'*JRPC-Server-Core' }
JRPCNotificationObject >> convertErrorToResponse: jrpcError [
	jrpcError isIncorrectJSON
		ifTrue: [ ^ jrpcError asJRPCResponseWithId: self id ].
	
	^ JRPCEmptyResponseObject new
]
