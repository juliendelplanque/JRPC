"
A JRPCMessageProcessorTest is a test class for testing the behavior of JRPCMessageProcessor
"
Class {
	#name : #JRPCMessageProcessorTest,
	#superclass : #TestCase,
	#category : #'JRPC-Tests'
}

{ #category : #test }
JRPCMessageProcessorTest >> testDebugMode [
	| messageProcessor |
	messageProcessor := JRPCMessageProcessor new.
	
	self deny: messageProcessor debugMode.
	
	messageProcessor debugMode: true.
	
	self assert: messageProcessor debugMode.
]

{ #category : #test }
JRPCMessageProcessorTest >> testDebugModeDoNotCatchError [
	| messageProcessor |
	messageProcessor := JRPCMessageProcessor new.
	messageProcessor debugMode: true.
	
	messageProcessor addHandlerNamed: 'error' block: [ Error signal ].
	
	self should: [ (JRPCRequestObject id: 1 method: 'error') beHandledBy: messageProcessor ]
		raise: Error.
		
	messageProcessor debugMode: false.
	
	self shouldnt: [ (JRPCRequestObject id: 1 method: 'error') beHandledBy: messageProcessor ]
		raise: Error.
]

{ #category : #test }
JRPCMessageProcessorTest >> testHandlerFor [
	| messageProcessor block handler |

	messageProcessor := JRPCMessageProcessor new.

	self should: [ messageProcessor handlerFor: (JRPCRequestObject id: 1 method: 'powerOf2') ] raise: JRPCNonExistentHandler.

	block := [ :anInteger | anInteger ** 2 ].

	messageProcessor addHandlerNamed: 'powerOf2' block: block.
	handler := messageProcessor handlerFor: (JRPCRequestObject id: 1 method: 'powerOf2').

	self
		assert: handler methodName equals: 'powerOf2';
		assert: handler block equals: block
]

{ #category : #test }
JRPCMessageProcessorTest >> testHandlerForHandlerThatDealWithNotificationOnly [
	| messageProcessor block handler |

	messageProcessor := JRPCMessageProcessor new.

	block := [ :anInteger | anInteger ** 2 ].

	messageProcessor addHandler: (JRPCBlockHandler new
											methodName: 'powerOf2';
											block: block;
											isForRequest: false;
											yourself).
	
	handler := messageProcessor handlerFor: (JRPCNotificationObject method: 'powerOf2').

	self
		assert: handler methodName equals: 'powerOf2';
		assert: handler block equals: block.
		
	self should: [ messageProcessor handlerFor: (JRPCRequestObject id: 1 method: 'powerOf2') ] raise: JRPCNonExistentHandler.
]

{ #category : #test }
JRPCMessageProcessorTest >> testHandlerForHandlerThatDealWithRequestOnly [
	| messageProcessor block handler |

	messageProcessor := JRPCMessageProcessor new.

	block := [ :anInteger | anInteger ** 2 ].

	messageProcessor addHandler: (JRPCBlockHandler new
											methodName: 'powerOf2';
											block: block;
											isForNotification: false;
											yourself).
	
	handler := messageProcessor handlerFor: (JRPCRequestObject id: 1 method: 'powerOf2').

	self
		assert: handler methodName equals: 'powerOf2';
		assert: handler block equals: block.
		
	self should: [ messageProcessor handlerFor: (JRPCNotificationObject method: 'powerOf2') ] raise: JRPCNonExistentHandler.
]
