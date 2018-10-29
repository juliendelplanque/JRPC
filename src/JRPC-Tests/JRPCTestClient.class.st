Class {
	#name : #JRPCTestClient,
	#superclass : #JRPCClient,
	#instVars : [
		'server'
	],
	#category : #'JRPC-Tests'
}

{ #category : #initialization }
JRPCTestClient >> initialize [
	super initialize.
	server := JRPCServer new
]

{ #category : #'private - sending' }
JRPCTestClient >> sendRequest: aJRPCRequestObject [
	^ server handleJRPCRequestObject: aJRPCRequestObject
]
