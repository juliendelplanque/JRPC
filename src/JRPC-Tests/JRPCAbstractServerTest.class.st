Class {
	#name : #JRPCAbstractServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'JRPC-Tests'
}

{ #category : #testing }
JRPCAbstractServerTest class >> isAbstract [
	^ self = JRPCAbstractServerTest
]

{ #category : #private }
JRPCAbstractServerTest >> checkPortAvailability [

	[ ( ZnNetworkingUtils serverSocketOn: self port ) close ]
		on: Error
		do: [ :error | self fail: ( 'Port <1p> is not available' expandMacrosWith: self port ) ]
]

{ #category : #'instance creation' }
JRPCAbstractServerTest >> newJRPCClient [
	^ self subclassResponsibility
]

{ #category : #private }
JRPCAbstractServerTest >> port [

	^ 7777
]

{ #category : #running }
JRPCAbstractServerTest >> tearDown [

	server ifNotNil: [ server stop ].
	server := nil.
	super tearDown
]

{ #category : #tests }
JRPCAbstractServerTest >> testDefaultPort [

	self assert: server defaultPort equals: 4000
]

{ #category : #tests }
JRPCAbstractServerTest >> testNotification [

	| notificationCount |

	notificationCount := 0.
	server addHandlerNamed: 'mail_sent' block: [ notificationCount := notificationCount + 1 ].

	self newJRPCClient notifyMethod: 'mail_sent'.

	self assert: notificationCount equals: 1
]

{ #category : #tests }
JRPCAbstractServerTest >> testNotificationWithInvalidMethod [

	| notificationCount |

	notificationCount := 0.
	server addHandlerNamed: 'mail_sent' block: [ notificationCount := notificationCount + 1 ].

	self newJRPCClient notifyMethod: 'invalid'.

	self assert: notificationCount equals: 0
]

{ #category : #tests }
JRPCAbstractServerTest >> testRequestOnInvalidEndpoint [

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

{ #category : #tests }
JRPCAbstractServerTest >> testRequestWithoutParameters [

	server addHandlerNamed: 'zero' block: [ 0 ].

	self assert: ( self newJRPCClient callMethod: 'zero' withId: 3 ) result equals: 0
]

{ #category : #tests }
JRPCAbstractServerTest >> testValidRequest [

	server addHandlerNamed: 'sum' block: [ :a :b | a + b ].

	self assert: ( self newJRPCClient callMethod: 'sum' arguments: #(1 3) withId: 1 ) result equals: 4
]
