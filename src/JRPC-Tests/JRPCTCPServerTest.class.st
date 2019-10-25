Class {
	#name : #JRPCTCPServerTest,
	#superclass : #JRPCAbstractServerTest,
	#category : #'JRPC-Tests'
}

{ #category : #'instance creation' }
JRPCTCPServerTest >> newJRPCClient [
	^ JRPCClient tcpForAddress: NetNameResolver localHostAddress port: self port
]

{ #category : #running }
JRPCTCPServerTest >> setUp [

	super setUp.
	self checkPortAvailability.
	server := JRPCServer tcp.
	server
		port: self port.
	self assert: server port equals: self port.
	server start
]
