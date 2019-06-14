Extension { #name : #Error }

{ #category : #'*JRPC-Common' }
Error >> asJRPCJSON [
	^ { 
		'errorClass' -> self className.
		'messageText' -> (self messageText ifNotNil: #asString).
		'tag' -> (self tag ifNotNil: #asString).
		'signaler' -> (self signaler ifNotNil: #asString).
		'signalerContext' -> (self signalerContext ifNotNil: #asString)
	} asDictionary
]

{ #category : #'*JRPC-Common' }
Error >> asJRPCResponse [
	^ self asJRPCResponseWithId: nil
]

{ #category : #'*JRPC-Common' }
Error >> asJRPCResponseWithId: anInteger [
	| response |
	response := JRPCErrorResponseObject id: anInteger error: JRPCErrorObject internalError.
	response error
		data: self asJRPCJSON.
	^ response
]
