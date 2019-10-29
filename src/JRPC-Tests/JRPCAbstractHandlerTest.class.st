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
