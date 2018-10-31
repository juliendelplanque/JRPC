"
I model a batch of responses answered by a server.

I hold an array of JRPCEmptyResponseObject / JRPCErrorResponseObject / JRPCSuccessyResponseObject.
"
Class {
	#name : #JRPCBatchResponseObject,
	#superclass : #JRPCResponseObject,
	#instVars : [
		'responses'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCBatchResponseObject class >> fromJRPCJSONObject: aJSONObject [
	aJSONObject isArray
		ifFalse: [ JRPCIncorrectJSON signal ].
		
	^ self new
		responses: (aJSONObject collect: [ :json | 
			(JRPCMessageObject classToInstantiateForJSONObject: json forClient: true)
				fromJRPCJSONObject: json ]);
		yourself
]

{ #category : #converting }
JRPCBatchResponseObject >> asJRPCJSON [
	^ self responses
		collect: #asJRPCJSON
		"JRPCEmptyResponseObjects will generate nil and should be removed from the JSON object"
		thenReject: #isNil
]

{ #category : #accessing }
JRPCBatchResponseObject >> responses [
	^ responses
]

{ #category : #accessing }
JRPCBatchResponseObject >> responses: anObject [
	responses := anObject
]
