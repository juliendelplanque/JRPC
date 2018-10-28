Extension { #name : #BlockClosure }

{ #category : #'*JRPC' }
BlockClosure >> jrpcExecuteWithParameters: anArrayOrDictionary [
	| arguments |
	anArrayOrDictionary isArray
		ifTrue: [ ^ self valueWithArguments: anArrayOrDictionary ].
		
	arguments := (anArrayOrDictionary associations sorted: [ :a :b |
		(self argumentNames indexOf: a key) < (self argumentNames indexOf: b key) ])
			collect: #value.
	
	^ self valueWithArguments: arguments
]

{ #category : #'*JRPC' }
BlockClosure >> jrpcParametersCount [
	^ self argumentCount
]

{ #category : #'*JRPC' }
BlockClosure >> jrpcParametersNames [
	^ self argumentNames asSet
]
