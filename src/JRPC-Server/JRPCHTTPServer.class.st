"
I am a JSON-RPC 2.0 server running over the HTTP protocol.

Internally, I use Zinc.
"
Class {
	#name : #JRPCHTTPServer,
	#superclass : #JRPCServer,
	#instVars : [
		'server'
	],
	#category : #'JRPC-Server'
}

{ #category : #defaults }
JRPCHTTPServer class >> defaultPort [
	^ 4000
]

{ #category : #defaults }
JRPCHTTPServer >> defaultPort [
	^ self class defaultPort
]

{ #category : #initialization }
JRPCHTTPServer >> initialize [

	super initialize.
	server := ZnServer defaultServerClass new.

	server
		port: self defaultPort;
		delegate:
			( ZnDispatcherDelegate new
				map: '/'
				to: [ :request :response | response entity: ( ZnEntity json: ( self handleJSON: request contents ) ) ] )
]

{ #category : #accessing }
JRPCHTTPServer >> port [
	^ server port
]

{ #category : #accessing }
JRPCHTTPServer >> port: anInteger [
	server port: anInteger
]

{ #category : #starting }
JRPCHTTPServer >> start [
	server start
]

{ #category : #starting }
JRPCHTTPServer >> stop [
	server stop
]
