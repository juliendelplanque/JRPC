Extension { #name : #BlockClosure }

{ #category : #'*JRPC-Common' }
BlockClosure >> jrpcExecuteWithParameters: anArrayOrDictionary [
	| arguments |
	anArrayOrDictionary ifNil: [ 
		^ self value ].
	anArrayOrDictionary isArray
		ifTrue: [ ^ self valueWithArguments: anArrayOrDictionary ].
		
	arguments := (anArrayOrDictionary associations sorted: [ :a :b |
		(self argumentNames indexOf: a key) < (self argumentNames indexOf: b key) ])
			collect: #value.
	
	^ self valueWithArguments: arguments
]

{ #category : #'*JRPC-Common' }
BlockClosure >> jrpcParametersCount [
	^ self argumentCount
]

{ #category : #'*JRPC-Common' }
BlockClosure >> jrpcParametersNames [
	^ self argumentNames asSet
]
