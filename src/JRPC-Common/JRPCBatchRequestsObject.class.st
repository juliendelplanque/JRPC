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
	#category : #'JRPC-Common-Core'
}

{ #category : #'instance creation' }
JRPCBatchRequestsObject class >> fromJRPCJSONObject: aJSONObject [
	aJSONObject isArray
		ifFalse: [ JRPCIncorrectJSON signal ].
		
	^ self 
		requests: (aJSONObject collect: [ :json | 
			[ (JRPCMessageObject classToInstantiateForJSONObject: json forClient: false)
				fromJRPCJSONObject: json
			] on: JRPCIncorrectJSON do: [ :error |
				error asJRPCResponse ] ])
]

{ #category : #'instance creation' }
JRPCBatchRequestsObject class >> requests: anObject [
	^ self new
		requests: anObject;
		yourself
]

{ #category : #converting }
JRPCBatchRequestsObject >> asJRPCJSON [
	^ self requests collect: #asJRPCJSON
]

{ #category : #accessing }
JRPCBatchRequestsObject >> requests [
	^ requests
]

{ #category : #accessing }
JRPCBatchRequestsObject >> requests: anObject [
	requests := anObject
]
