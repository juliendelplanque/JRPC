"
I model a notification sent by a client as defined in JSON-RPC 2.0 spec [1].

My particularity compared to my superclass is that my corresponding JSON object does not hold an id field.

The server silently process the notification without returning a response to the client.

[1]: https://www.jsonrpc.org/specification
"
Class {
	#name : #JRPCNotificationObject,
	#superclass : #JRPCRequestObject,
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCNotificationObject class >> fromJRPCJSONObject: aDictionary [
	^ self new
		jsonrpc: (aDictionary at: 'jsonrpc');
		method: (aDictionary at: 'method');
		params: (aDictionary at: 'params' ifAbsent: [ nil ]);
		yourself
]

{ #category : #converting }
JRPCNotificationObject >> asJRPCJSON [
	| dict |
	dict := super asJRPCJSON.
	dict removeKey: 'id'.
	^ dict
]

{ #category : #'server handling' }
JRPCNotificationObject >> beHandledByServer: aJRPCServer [
	| response |
	response := super beHandledByServer: aJRPCServer.
	"If the response is an error invalid request, it should be returned even if the request was a notification."
	(response isError and: [ response isInvalidRequest ])
		ifTrue: [ ^ response ].
		
	^ JRPCEmptyResponseObject new
]

{ #category : #'server handling' }
JRPCNotificationObject >> convertErrorToResponse: jrpcError [
	jrpcError isIncorrectJSON
		ifTrue: [ ^ jrpcError asJRPCResponseWithId: self id ].
	
	^ JRPCEmptyResponseObject new
]
