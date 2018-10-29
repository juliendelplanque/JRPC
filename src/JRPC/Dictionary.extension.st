Extension { #name : #Dictionary }

{ #category : #'*JRPC' }
Dictionary >> asJRPCJSON [
	^ (self associations collect: [ :assoc |
		self assert: assoc key isString.
		assoc key -> assoc value asJRPCJSON ]) asDictionary
]
