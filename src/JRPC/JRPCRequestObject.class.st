Class {
	#name : #JRPCRequestObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'method',
		'params'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCRequestObject class >> fromDictionary: aDictionary [
	^ (super fromDictionary: aDictionary)
		method: (aDictionary at: 'method');
		params: (aDictionary at: 'params');
		yourself
]

{ #category : #'dictionary building' }
JRPCRequestObject >> buildDictionary: aDictionary [
	super buildDictionary: aDictionary.
	aDictionary
		at: 'method' put: self method.
	self params ifNotNil: [
		aDictionary at: 'params' put: self params ]
]

{ #category : #accessing }
JRPCRequestObject >> method [
	^ method
]

{ #category : #accessing }
JRPCRequestObject >> method: anObject [
	method := anObject
]

{ #category : #accessing }
JRPCRequestObject >> params [
	^ params
]

{ #category : #accessing }
JRPCRequestObject >> params: anObject [
	params := anObject
]
