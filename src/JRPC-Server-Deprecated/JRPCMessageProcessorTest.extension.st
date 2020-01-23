Extension { #name : #JRPCMessageProcessorTest }

{ #category : #'*JRPC-Server-Deprecated' }
JRPCMessageProcessorTest >> testHandlerForName [

	| messageProcessor block handler |

	messageProcessor := JRPCMessageProcessor new.

	self should: [ messageProcessor handlerForName: 'powerOf2' ] raise: JRPCNonExistentHandler.

	block := [ :anInteger | anInteger ** 2 ].

	messageProcessor addHandlerNamed: 'powerOf2' block: block.
	handler := messageProcessor handlerForName: 'powerOf2'.

	self
		assert: handler methodName equals: 'powerOf2';
		assert: handler block equals: block
]
