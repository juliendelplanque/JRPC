Class {
	#name : #JRPCBatchRequestsObject,
	#superclass : #JRPCJsonableObject,
	#instVars : [
		'requests'
	],
	#category : #'JRPC-Core'
}

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
