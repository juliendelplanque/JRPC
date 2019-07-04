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
JRPCHttpServerTest >> newJRPCClient [

	^ ( JRPCClient http: ( 'http://localhost' asUrl port: self port ) )
		ifFail: [ self fail ];
		yourself
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
	server
		port: self port;
		debugMode: true.
	self
		assert: server port equals: self port;
		assert: server debugMode.
	server start
]

{ #category : #running }
JRPCHttpServerTest >> tearDown [

	server ifNotNil: [ server stop ].
	server := nil.
	super tearDown
]

{ #category : #accessing }
JRPCHttpServerTest >> testNotification [

	| notificationCount |

	notificationCount := 0.
	server addHandlerNamed: 'mail_sent' block: [ notificationCount := notificationCount + 1 ].

	self newJRPCClient notifyMethod: 'mail_sent'.

	self assert: notificationCount equals: 1
]

{ #category : #accessing }
JRPCHttpServerTest >> testNotificationWithInvalidMethod [

	| notificationCount |

	notificationCount := 0.
	server addHandlerNamed: 'mail_sent' block: [ notificationCount := notificationCount + 1 ].

	self newJRPCClient notifyMethod: 'invalid'.

	self assert: notificationCount equals: 0
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
JRPCHttpServerTest >> testRequestWithoutParameters [

	server addHandlerNamed: 'zero' block: [ 0 ].

	self assert: ( self newJRPCClient callMethod: 'zero' withId: 3 ) result equals: 0
]

{ #category : #accessing }
JRPCHttpServerTest >> testValidRequest [

	server addHandlerNamed: 'sum' block: [ :a :b | a + b ].

	self assert: ( self newJRPCClient callMethod: 'sum' arguments: #(1 3) withId: 1 ) result equals: 4
]
