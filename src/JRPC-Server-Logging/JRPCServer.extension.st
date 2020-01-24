Extension { #name : #JRPCServer }

{ #category : #'*JRPC-Server-Logging' }
JRPCServer >> enableLogging: aBoolean [
	(aBoolean and: [ self messageProcessor isLogger ])
		ifTrue: [ ^self "Logging is already activated." ].
		
	(aBoolean not and: [self messageProcessor isLogger not ])
		ifTrue: [ ^ self "Logging is alread deactivated." ].
		
	aBoolean
		ifTrue: [ messageProcessor := (JRPCMessageProcessorLogger decorate: self messageProcessor) ]
		ifFalse: [ messageProcessor := self messageProcessor decoratedMessageProcessor ]
]
