Class {
	#name : #JRPCServerLoggingExtensionsTest,
	#superclass : #TestCase,
	#category : #'JRPC-Server-Logging-Tests'
}

{ #category : #tests }
JRPCServerLoggingExtensionsTest >> testEnableLogging [
	| server |
	server := JRPCServer http.
	
	self deny: server isLoggingEnabled.
	
	server enableLogging: true.
	self assert: server isLoggingEnabled.
	
	server enableLogging: true. "Checking twice with true value ensure the logic of #enableLogging: is correct."
	self assert: server isLoggingEnabled.
	
	server enableLogging: false.
	self deny: server isLoggingEnabled.
	
	server enableLogging: false. "Checking twice with false value ensure the logic of #enableLogging: is correct."
	self deny: server isLoggingEnabled.
]
