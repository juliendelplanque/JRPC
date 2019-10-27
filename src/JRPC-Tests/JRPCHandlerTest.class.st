Class {
	#name : #JRPCHandlerTest,
	#superclass : #TestCase,
	#category : #'JRPC-Tests'
}

{ #category : #test }
JRPCHandlerTest >> testExecuteWithArgumentsBeingArray [
	| handler |
	handler := JRPCMockHandler new.
	
	self assertCollection: (handler executeWithArguments: #(1 2)) equals: 3
]

{ #category : #test }
JRPCHandlerTest >> testExecuteWithArgumentsDictionary [
	| handler |
	handler := JRPCMockHandler new.
	
	self assertCollection: (handler executeWithArguments: { 'x' -> 1. 'y' -> 2 } asDictionary) equals: 3
]

{ #category : #test }
JRPCHandlerTest >> testGetMethodSelectorFromPragma [
	| handler |
	handler := JRPCMockHandler new.
	
	self assert: handler getMethodSelectorFromPragma equals: #add:with:
]

{ #category : #test }
JRPCHandlerTest >> testParametersCount [
	| handler |
	handler := JRPCMockHandler new.
	
	self assert: handler parametersCount equals: 2
]

{ #category : #test }
JRPCHandlerTest >> testParametersNames [
	| handler |
	handler := JRPCMockHandler new.
	
	self assertCollection: handler parametersNames equals: #(#x #y)
]
