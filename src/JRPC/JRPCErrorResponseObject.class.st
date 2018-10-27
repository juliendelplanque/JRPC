Class {
	#name : #JRPCErrorResponseObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'error'
	],
	#category : #'JRPC-Core'
}

{ #category : #'dictionary building' }
JRPCErrorResponseObject >> buildDictionary: aDictionary [
	super buildDictionary: aDictionary.
	aDictionary
		at: 'error' put: self error asDictionary
]

{ #category : #accessing }
JRPCErrorResponseObject >> error [
	^ error
]

{ #category : #accessing }
JRPCErrorResponseObject >> error: anObject [
	error := anObject
]
