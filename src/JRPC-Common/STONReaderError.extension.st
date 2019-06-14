Extension { #name : #STONReaderError }

{ #category : #'*JRPC-Common' }
STONReaderError >> asJRPCResponse [
	^ JRPCErrorResponseObject id: nil error: JRPCErrorObject parseError
]
