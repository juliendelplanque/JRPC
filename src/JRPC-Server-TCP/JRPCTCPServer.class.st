"
I am a JSON-RPC 2.0 server running over the TCP protocol.

Internally, I use a Socket.
"
Class {
	#name : #JRPCTCPServer,
	#superclass : #JRPCServer,
	#instVars : [
		'port',
		'tcpServer',
		'serverLoop',
		'process'
	],
	#category : #'JRPC-Server-TCP'
}

{ #category : #defaults }
JRPCTCPServer class >> defaultPort [
	^ 4000
]

{ #category : #defaults }
JRPCTCPServer >> defaultPort [
	^ self class defaultPort
]

{ #category : #accessing }
JRPCTCPServer >> port [
	^ port ifNil: [ port := self defaultPort ]
]

{ #category : #accessing }
JRPCTCPServer >> port: anObject [
	port := anObject
]

{ #category : #starting }
JRPCTCPServer >> start [
	tcpServer := Socket newTCP.
	tcpServer listenOn: self port backlogSize: 10.
	serverLoop := true.
	process := [ [ serverLoop ]
		whileTrue: [ (tcpServer waitForAcceptFor: 60)
				ifNotNil: [ :clientSocket | 
					[ [ 
					| data |
					data := clientSocket receiveData.
					clientSocket sendData: (self handleJSON: data contents) ]
						ensure: [ clientSocket closeAndDestroy ] ]
						forkAt: Processor lowIOPriority
						named: 'JRPC TCP connection' ] ] ]
		forkAt: Processor highIOPriority
		named: 'JRPC TCP server'
]

{ #category : #stopping }
JRPCTCPServer >> stop [
	serverLoop := false.
	tcpServer closeAndDestroy.
	
	"Ensure process finishes."
	process isTerminated
		ifTrue: [ ^ self ].
	process terminate
]
