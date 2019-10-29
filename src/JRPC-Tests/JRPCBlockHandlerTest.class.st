"
A JRPCBlockHandlerTest is a test class for testing the behavior of JRPCBlockHandler
"
Class {
	#name : #JRPCBlockHandlerTest,
	#superclass : #TestCase,
	#category : #'JRPC-Tests'
}

{ #category : #test }
JRPCBlockHandlerTest >> testExecuteWithArgumentsBeingArray [
	| handler |
	handler := JRPCBlockHandler methodName: 'test' block: [ :x :y | x + y ].
	
	self assertCollection: (handler executeWithArguments: #(1 2)) equals: 3
]

{ #category : #test }
JRPCBlockHandlerTest >> testExecuteWithArgumentsDictionary [
	| handler |
	handler := JRPCBlockHandler methodName: 'test' block: [ :x :y | x + y ].
	
	self assertCollection: (handler executeWithArguments: { 'x' -> 1. 'y' -> 2 } asDictionary) equals: 3
]

{ #category : #test }
JRPCBlockHandlerTest >> testParametersCount [
	| handler |
	handler := JRPCBlockHandler methodName: 'test' block: [ :x :y | x + y ].
	
	self assert: handler parametersCount equals: 2
]

{ #category : #test }
JRPCBlockHandlerTest >> testParametersNames [
	| handler |
	handler := JRPCBlockHandler methodName: 'test' block: [ :x :y | x + y ].
	
	self assertCollection: handler parametersNames equals: #(#x #y)
]

{ #category : #test }
JRPCBlockHandlerTest >> testUnnamedBlockHandlerRaiseErrorWhenMethodNameIsAsked [
	| handler |
	handler := JRPCBlockHandler new
					block: [ :x :y | x + y ];
					yourself.
					
	self should: [ handler methodName ] raise: Error withExceptionDo: [ :error |
		error description = 'It is mandatory to specify the #methodName of a block handler via #methodName: method on instance side.' ]
]
