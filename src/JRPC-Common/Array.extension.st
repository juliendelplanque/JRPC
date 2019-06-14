Extension { #name : #Array }

{ #category : #'*JRPC-Common' }
Array >> asJRPCJSON [
	^ self collect: #asJRPCJSON
]
