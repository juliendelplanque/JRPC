"
I model a batch of responses answered by a server.

I hold an array of JRPCEmptyResponseObject / JRPCErrorResponseObject / JRPCSuccessyResponseObject.
"
Class {
	#name : #JRPCBatchResponseObject,
	#superclass : #JRPCJsonableObject,
	#instVars : [
		'responses'
	],
	#category : #'JRPC-Common-Core'
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

{ #category : #'server conversion' }
JRPCBatchResponseObject >> beConvertedBy: aJRPCMessageProcessor [

	| jsonObject |

	jsonObject := self asJRPCJSON.
	jsonObject ifEmpty: [ ^ '' ].
	^ aJRPCMessageProcessor convertJRPCJsonableObjectToJSON: jsonObject
]

{ #category : #accessing }
JRPCBatchResponseObject >> responses [
	^ responses
]

{ #category : #accessing }
JRPCBatchResponseObject >> responses: anObject [
	responses := anObject
]
