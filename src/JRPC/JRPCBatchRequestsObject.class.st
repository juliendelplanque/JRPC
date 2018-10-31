"
I model a batch of requests sent by a client.

I hold an array of requests or notifications.
"
Class {
	#name : #JRPCBatchRequestsObject,
	#superclass : #JRPCJsonableObject,
	#instVars : [
		'requests'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCBatchRequestsObject class >> fromJRPCJSONObject: aJSONObject [
	aJSONObject isArray
		ifFalse: [ JRPCIncorrectJSON signal ].
		
	^ self new
		requests: (aJSONObject collect: [ :json | 
			(JRPCMessageObject classToInstantiateForJSONObject: json forClient: false)
				fromJRPCJSONObject: json ]);
		yourself
]

{ #category : #converting }
JRPCBatchRequestsObject >> asJRPCJSON [
	^ self requests collect: #asJRPCJSON
]

{ #category : #'server handling' }
JRPCBatchRequestsObject >> beHandledByServer: aJRPCHTTPServer [ 
	^ JRPCBatchResponseObject new
		responses: (self requests collect: [ :req |
						req beHandledByServer: aJRPCHTTPServer ]);
		yourself
]

{ #category : #accessing }
JRPCBatchRequestsObject >> requests [
	^ requests
]

{ #category : #accessing }
JRPCBatchRequestsObject >> requests: anObject [
	requests := anObject
]
