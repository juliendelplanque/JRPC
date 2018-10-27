Class {
	#name : #JRPCSuccessResponseObject,
	#superclass : #JRPCMessageObject,
	#instVars : [
		'result'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCSuccessResponseObject class >> fromDictionary: aDictionary [
	^ (super fromDictionary: aDictionary)
		result: (aDictionary at: 'result')
]

{ #category : #'dictionary building' }
JRPCSuccessResponseObject >> buildDictionary: aDictionary [
	super buildDictionary: aDictionary.
	aDictionary
		at: 'result' put: self result
]

{ #category : #accessing }
JRPCSuccessResponseObject >> result [
	^ result
]

{ #category : #accessing }
JRPCSuccessResponseObject >> result: anObject [
	result := anObject
]
