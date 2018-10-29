Class {
	#name : #JRPCTestClient,
	#superclass : #JRPCAbstractClient,
	#instVars : [
		'server'
	],
	#category : #'JRPC-Tests'
}

{ #category : #initialization }
JRPCTestClient >> initialize [
	super initialize.
	server := JRPCAbstractServer new
]

{ #category : #'private - sending' }
JRPCTestClient >> sendRequest: aJRPCRequestObject [
	^ server handleJRPCRequestObject: aJRPCRequestObject
]
