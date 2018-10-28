Class {
	#name : #JRPCErrorResponseObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'error'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCErrorResponseObject class >> fromDictionary: aDictionary [
	^ (super fromDictionary: aDictionary)
		error: (aDictionary at: 'error')
]

{ #category : #'instance creation' }
JRPCErrorResponseObject class >> id: anInteger error: aJRPCErrorObject [
	^ self new
		id: anInteger;
		error: aJRPCErrorObject
]

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
