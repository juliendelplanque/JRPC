"
I am an abstract class defining the fact that an object can be converted as a JSON object.

My subclasses must define:
- #asJRPCJSON : which defines how to create a JSON object to represent the object.
- #fromDictionary: (class-side) which defines how to build an object from a dictionary representing it.
"
Class {
	#name : #JRPCJsonableObject,
	#superclass : #Object,
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCJsonableObject class >> fromJRPCJSONObject: aJSONObject [
	"Builds myself using aJSONObject.
	 Must be implemented by concrete subclasses.
	"
	^ self subclassResponsibility
]

{ #category : #converting }
JRPCJsonableObject >> asJRPCJSON [
	"Returns a JSON object that suits well for the JSON-RPC 2.0 protocol.
	 To be overrided by subclasses."
	^ self subclassResponsibility
]
