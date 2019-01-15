"
I am a client for JSON-RPC 2.0 over HTTP.

Internally, I use Zinc.
"
Class {
	#name : #JRPCHTTPClient,
	#superclass : #JRPCClient,
	#instVars : [
		'url'
	],
	#category : #'JRPC-Clients'
}

{ #category : #'instance creation' }
JRPCHTTPClient class >> url: anObject [
	^ self new
		url: anObject;
		yourself
]

{ #category : #private }
JRPCHTTPClient >> httpClient [
	^ ZnClient new
		systemPolicy;
		http;
		url: self url;
		yourself
]

{ #category : #'private - sending' }
JRPCHTTPClient >> sendRequest: aJRPCRequestObject [
	| result |
	result := self httpClient
		contents: (self convertJRPCJsonableObjectToJSON: aJRPCRequestObject asJRPCJSON);
		get.
		
	^ self parseSupposedJRPCMessageObjectFromString: (result ifNil: [ '' ] ifNotNil: #contents).
]

{ #category : #accessing }
JRPCHTTPClient >> url [
	^ url
]

{ #category : #accessing }
JRPCHTTPClient >> url: anObject [
	url := anObject asZnUrl
]
