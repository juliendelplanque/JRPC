Extension { #name : #JRPCNotificationObject }

{ #category : #'*JRPC-Server' }
JRPCNotificationObject >> beHandledByServer: aJRPCServer [
	| response |
	response := super beHandledByServer: aJRPCServer.
	"If the response is an error invalid request, it should be returned even if the request was a notification."
	(response isError and: [ response isInvalidRequest ])
		ifTrue: [ ^ response ].
		
	^ JRPCEmptyResponseObject new
]

{ #category : #'*JRPC-Server' }
JRPCNotificationObject >> convertErrorToResponse: jrpcError [
	jrpcError isIncorrectJSON
		ifTrue: [ ^ jrpcError asJRPCResponseWithId: self id ].
	
	^ JRPCEmptyResponseObject new
]
