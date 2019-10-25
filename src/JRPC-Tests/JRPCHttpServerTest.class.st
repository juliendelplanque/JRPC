"
I'm a test for JSON RPC over HTTP transport
"
Class {
	#name : #JRPCHttpServerTest,
	#superclass : #JRPCAbstractServerTest,
	#category : #'JRPC-Tests'
}

{ #category : #private }
JRPCHttpServerTest >> newJRPCClient [

	^ ( JRPCClient http: ( 'http://localhost' asUrl port: self port ) )
		ifFail: [ self fail ];
		yourself
]

{ #category : #running }
JRPCHttpServerTest >> setUp [

	super setUp.
	self checkPortAvailability.
	server := JRPCServer http.
	server
		port: self port;
		debugMode: true.
	self
		assert: server port equals: self port;
		assert: server debugMode.
	server start
]
