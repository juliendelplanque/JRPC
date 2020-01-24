"
I model a log of communication between a client and the server.
"
Class {
	#name : #JRPCCommunicationLog,
	#superclass : #Object,
	#instVars : [
		'incomingJSON',
		'answerJSON',
		'timestamp'
	],
	#category : #'JRPC-Server-Logging'
}

{ #category : #'instance creation' }
JRPCCommunicationLog class >> incomingJSON: incomingJSON answerJSON: answerJSON [
	^ self new
		incomingJSON: incomingJSON;
		answerJSON: answerJSON;
		yourself
]

{ #category : #accessing }
JRPCCommunicationLog >> answerJSON [
	^ answerJSON
]

{ #category : #accessing }
JRPCCommunicationLog >> answerJSON: anObject [
	answerJSON := anObject
]

{ #category : #accessing }
JRPCCommunicationLog >> incomingJSON [
	^ incomingJSON
]

{ #category : #accessing }
JRPCCommunicationLog >> incomingJSON: anObject [
	incomingJSON := anObject
]

{ #category : #printing }
JRPCCommunicationLog >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self timestamp printOn: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
JRPCCommunicationLog >> timestamp [
	^ timestamp
]

{ #category : #accessing }
JRPCCommunicationLog >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #api }
JRPCCommunicationLog >> timestampBeNow [
	self timestamp: DateAndTime now
]
