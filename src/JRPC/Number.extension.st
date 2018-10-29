Extension { #name : #Number }

{ #category : #'*JRPC' }
Number >> asJRPCJSON [
	^ self asFloat
]
