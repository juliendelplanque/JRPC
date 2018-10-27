Class {
	#name : #JRPCRequestObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'method',
		'params'
	],
	#category : #'JRPC-Core'
}

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
