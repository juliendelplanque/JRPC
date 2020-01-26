"
A JRPCMessageProcessorLoggerTest is a test class for testing the behavior of JRPCMessageProcessorLogger
"
Class {
	#name : #JRPCMessageProcessorLoggerTest,
	#superclass : #TestCase,
	#category : #'JRPC-Server-Logging-Tests'
}

{ #category : #test }
JRPCMessageProcessorLoggerTest >> testHandleJSON [
	| messageProcessor logger jsonRequest jsonResult |
	messageProcessor := JRPCMessageProcessor new.
	messageProcessor addHandler: (JRPCBlockHandler new
											methodName: 'powerOf2';
											block: [ :anInteger | anInteger ** 2 ];
											yourself).
	logger := JRPCMessageProcessorLogger decorate: messageProcessor.
	
	self assert: logger logs isEmpty.
	
	jsonRequest := STONJSON toString: (JRPCRequestObject id: 1 method: 'powerOf2' params: { 2 }) asJRPCJSON.
	jsonResult := logger handleJSON: jsonRequest.
	
	self assert: logger logs size equals: 1.
	self assert: logger logs first incomingJSON equals: jsonRequest.
	self assert: logger logs first answerJSON equals: jsonResult.
	
	jsonRequest := STONJSON toString: (JRPCRequestObject id: 2 method: 'powerOf2' params: { 3 }) asJRPCJSON.
	jsonResult := logger handleJSON: jsonRequest.
	
	self assert: logger logs size equals: 2.
	self assert: logger logs second incomingJSON equals: jsonRequest.
	self assert: logger logs second answerJSON equals: jsonResult.
]
