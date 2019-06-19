"
I'm a test for JSON RPC over HTTP transport
"
Class {
	#name : #JRPCHttpServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'JRPC-Tests'
}

{ #category : #private }
JRPCHttpServerTest >> checkPortAvailability [

	[ ( ZnNetworkingUtils serverSocketOn: self port ) close ]
		on: Error
		do: [ :error | self fail: ( 'Port <1p> is not available' expandMacrosWith: self port ) ]
]

{ #category : #private }
JRPCHttpServerTest >> port [

	^ 7777
]

{ #category : #running }
JRPCHttpServerTest >> setUp [

	super setUp.
	self checkPortAvailability.
	server := JRPCServer http.
	server port: self port.
	server start
]

{ #category : #running }
JRPCHttpServerTest >> tearDown [

	server ifNotNil: [ server stop ].
	server := nil.
	super tearDown
]

{ #category : #accessing }
JRPCHttpServerTest >> testRequestOnInvalidEndpoint [

	| httpClient failed |

	server addHandlerNamed: 'sum' block: [ :a :b | a + b ].
	failed := false.

	httpClient := JRPCClient http: ( 'http://localhost' asUrl port: self port ) / 'bad'.
	httpClient
		ifFail: [ :error | 
			failed := true.
			'{}'
			].
	self
		should: [ httpClient callMethod: 'sum' arguments: #(1 3) withId: 1 ] raise: JRPCIncorrectJSON;
		assert: failed
]

{ #category : #accessing }
JRPCHttpServerTest >> testValidRequest [

	| httpClient |

	server addHandlerNamed: 'sum' block: [ :a :b | a + b ].

	httpClient := JRPCClient http: ( 'http://localhost' asUrl port: self port ).

	self assert: ( httpClient callMethod: 'sum' arguments: #(1 3) withId: 1 ) result equals: 4
]
