Extension { #name : #STONReaderError }

{ #category : #'*JRPC' }
STONReaderError >> asJRPCResponse [
	^ JRPCErrorResponseObject id: nil error: JRPCErrorObject parseError
]
