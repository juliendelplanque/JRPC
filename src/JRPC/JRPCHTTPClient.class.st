Class {
	#name : #JRPCHTTPClient,
	#superclass : #JRPCAbstractClient,
	#instVars : [
		'url'
	],
	#category : #'JRPC-Clients'
}

{ #category : #private }
JRPCHTTPClient >> httpClient [
	^ ZnClient new
		systemPolicy;
		http;
		url: self url;
		yourself
]

{ #category : #sending }
JRPCHTTPClient >> sendRequest: aJRPCRequestObject [
	| result |
	result := self httpClient
		contents: (self convertJRPCDictionaryObjectToJSON: aJRPCRequestObject);
		get.
		
	^ self parseSupposedJRPCMessageObjectFromString: result contents.
]

{ #category : #accessing }
JRPCHTTPClient >> url [
	^ url
]

{ #category : #accessing }
JRPCHTTPClient >> url: anObject [
	url := anObject asZnUrl
]
