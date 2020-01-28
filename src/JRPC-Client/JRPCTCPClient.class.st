"
I am a client for JSON-RPC 2.0 over TCP.

Internally, I use a Socket.
"
Class {
	#name : #JRPCTCPClient,
	#superclass : #JRPCClient,
	#instVars : [
		'address',
		'port'
	],
	#category : #'JRPC-Client'
}

{ #category : #defaults }
JRPCTCPClient class >> defaultPort [
	^ 4000
]

{ #category : #accessing }
JRPCTCPClient >> address [
	^ address ifNil: [ address := NetNameResolver localHostAddress ]
]

{ #category : #accessing }
JRPCTCPClient >> address: anObject [
	address := anObject
]

{ #category : #accessing }
JRPCTCPClient >> defaultPort [
	^ self class defaultPort
]

{ #category : #accessing }
JRPCTCPClient >> port [
	^ port ifNil: [ port := self defaultPort ]
]

{ #category : #accessing }
JRPCTCPClient >> port: anObject [
	port := anObject
]

{ #category : #'private - sending' }
JRPCTCPClient >> sendRequestContent: aString [
	| socket result |
	socket := Socket newTCP.
	socket
		connectTo: self address
		port: self port.
	socket sendData: aString.
	result := socket receiveData.
	socket closeAndDestroy.
	^ result
]
