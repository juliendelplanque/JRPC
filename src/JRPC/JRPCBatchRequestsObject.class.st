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
			(JRPCMessageObject classToInstantiateForJSONObject: json)
				fromJRPCJSONObject: json ]);
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
