"
A JRPCAbstractHandlerTest is a test class for testing the behavior of JRPCAbstractHandler
"
Class {
	#name : #JRPCAbstractHandlerTest,
	#superclass : #TestCase,
	#category : #'JRPC-Tests'
}

{ #category : #test }
JRPCAbstractHandlerTest >> testCheckParametersForRequest [
	| handler |
	handler := JRPCBlockHandler methodName: 'test' block: [ :x | ].
	self should: [ 
		handler checkParametersForRequest: JRPCRequestObject new
	] raise: JRPCInvalidParameters.
	
	self should: [ 
		handler checkParametersForRequest: (JRPCRequestObject new params: #(1 2); yourself)
	] raise: JRPCInvalidParameters.

	self should: [ 
		handler checkParametersForRequest: (JRPCRequestObject new params: { #x -> 1 . #y -> 2 } asDictionary; yourself)
	] raise: JRPCInvalidParameters.
	
	self should: [ 
		handler checkParametersForRequest: (JRPCRequestObject new params: { #y -> 1 } asDictionary; yourself)
	] raise: JRPCInvalidParameters.
	
	"The two next will not raise error."
	handler checkParametersForRequest: (JRPCRequestObject new params: #(1); yourself).
		
	handler checkParametersForRequest: (JRPCRequestObject new params: { #x -> 1 } asDictionary; yourself)
]

{ #category : #test }
JRPCAbstractHandlerTest >> testEquality [
	| handler1 handler2 |
	handler1 := JRPCBlockHandler new
						methodName: 'foo';
						yourself.
	handler2 := JRPCBlockHandler new
						methodName: 'foo';
						yourself.
						
	self assert: handler1 equals: handler2
]

{ #category : #test }
JRPCAbstractHandlerTest >> testEquality2 [
	| handler1 handler2 |
	handler1 := JRPCBlockHandler new
						methodName: 'foo';
						yourself.
	handler2 := JRPCBlockHandler new
						methodName: 'bar';
						yourself.
						
	self deny: handler1 equals: handler2
]

{ #category : #test }
JRPCAbstractHandlerTest >> testEquality3 [
	| handler1 handler2 |
	handler1 := JRPCBlockHandler new
						methodName: 'foo';
						isForNotification: false;
						yourself.
	handler2 := JRPCBlockHandler new
						methodName: 'foo';
						yourself.
						
	self deny: handler1 equals: handler2
]

{ #category : #test }
JRPCAbstractHandlerTest >> testEquality4 [
	| handler1 handler2 |
	handler1 := JRPCBlockHandler new
						methodName: 'foo';
						isForNotification: false;
						yourself.
	handler2 := JRPCBlockHandler new
						methodName: 'foo';
						isForNotification: false;
						yourself.
						
	self assert: handler1 equals: handler2
]

{ #category : #test }
JRPCAbstractHandlerTest >> testEquality5 [
	| handler1 handler2 |
	handler1 := JRPCBlockHandler new
						methodName: 'foo';
						isForRequest: false;
						yourself.
	handler2 := JRPCBlockHandler new
						methodName: 'foo';
						yourself.
						
	self deny: handler1 equals: handler2
]

{ #category : #test }
JRPCAbstractHandlerTest >> testEquality6 [
	| handler1 handler2 |
	handler1 := JRPCBlockHandler new
						methodName: 'foo';
						isForRequest: false;
						yourself.
	handler2 := JRPCBlockHandler new
						methodName: 'foo';
						isForRequest: false;
						yourself.
						
	self assert: handler1 equals: handler2
]

{ #category : #test }
JRPCAbstractHandlerTest >> testIsForRequestAndIsForNotificationSetters [
	| handler |
	handler := JRPCBlockHandler methodName: 'test' block: [ :x | ].
	
	self assert: handler isForNotification.
	self assert: handler isForRequest.
	
	handler isForNotification: false.
	self deny: handler isForNotification.
	self assert: handler isForRequest.
	
	self should: [ handler isForRequest: false ] raise: Error.
	
	handler isForNotification: true.
	self assert: handler isForNotification.
	self assert: handler isForRequest.
	
	handler isForRequest: false.
	self assert: handler isForNotification.
	self deny: handler isForRequest.
	
	self should: [ handler isForNotification: false ] raise: Error.
]
