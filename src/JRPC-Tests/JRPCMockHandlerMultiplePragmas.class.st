Class {
	#name : #JRPCMockHandlerMultiplePragmas,
	#superclass : #JRPCHandler,
	#category : #'JRPC-Tests'
}

{ #category : #accessing }
JRPCMockHandlerMultiplePragmas class >> defaultMethodName [
	^ 'mock'
]

{ #category : #adding }
JRPCMockHandlerMultiplePragmas >> method1 [
	<jrpc>
	^ 1
]

{ #category : #adding }
JRPCMockHandlerMultiplePragmas >> method2 [
	<jrpc>
	^ 2
]
