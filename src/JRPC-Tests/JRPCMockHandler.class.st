Class {
	#name : #JRPCMockHandler,
	#superclass : #JRPCHandler,
	#category : #'JRPC-Tests'
}

{ #category : #accessing }
JRPCMockHandler class >> defaultMethodName [
	^ 'mock'
]

{ #category : #adding }
JRPCMockHandler >> add: x with: y [
	<jrpc>
	^ x + y
]
