Extension { #name : #Array }

{ #category : #'*JRPC' }
Array >> asJRPCJSON [
	^ self collect: #asJRPCJSON
]
