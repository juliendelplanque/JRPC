Extension { #name : #TestAsserter }

{ #category : #'*JRPC-Server-Pharo6' }
TestAsserter >> deny: actual equals: expected [
	^ self
		assert: expected ~= actual
		description: [self unexpectedEqualityStringBetween: actual and: expected]
]

{ #category : #'*JRPC-Server-Pharo6' }
TestAsserter >> unexpectedEqualityStringBetween: actual and: expected [

	^ String streamContents: [:stream |
			stream
				nextPutAll: 'Unexpected equality of ';
				nextPutAll: actual fullPrintString;
				nextPutAll: ' and ';
				nextPutAll: expected fullPrintString;
				nextPutAll: '.']
]
