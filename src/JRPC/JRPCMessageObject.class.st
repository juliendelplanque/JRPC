"
I am an abstract message object in JSON-RPC 2.0.

I hold:
- #id : the id allowing to uniquely identify a request and its corresponding response.
- #jsonrpc : the version of JSON-RPC used (always 2.0 in this framework).
"
Class {
	#name : #JRPCMessageObject,
	#superclass : #JRPCJsonableObject,
	#instVars : [
		'jsonrpc',
		'id'
	],
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Core'
}

{ #category : #accessing }
JRPCMessageObject class >> classToInstantiateForDictionary: aDictionary [
	"Given aDictionary, returns the right class to instantiate in order to get
	 the model object corresponding.
	"
	aDictionary
		at: 'jsonrpc' "This MUST be in messages."
		ifPresent: [ :value |
			value = JSONRPC ifFalse: [ self error: 'Unsupported version of JSON-RPC. I can only handle JSON-RPC 2.0.' ].
			
			"Determine if JRPCErrorResponseObject or JRPCSuccessResponseObject"
			(aDictionary includesKey: 'result')
				ifTrue: [ ^ JRPCSuccessResponseObject ].
			
			(aDictionary includesKey: 'error')
				ifTrue: [ ^ JRPCErrorResponseObject ].
			
			(aDictionary includesKey: 'method')
				ifTrue: [ ^ JRPCRequestObject ] ].
	
	JRPCIncorrectJSON signal: 'Incorrect JSON, no class to instantiate for it.'
]

{ #category : #'instance creation' }
JRPCMessageObject class >> fromJRPCJSONObject: aDictionary [
	^ self new
		jsonrpc: (aDictionary at: 'jsonrpc');
		id: (aDictionary at: 'id');
		yourself
]

{ #category : #converting }
JRPCMessageObject >> asJRPCJSON [
	^ Dictionary new
		at: 'jsonrpc' put: self jsonrpc asJRPCJSON;
		at: 'id' put: self id asJRPCJSON;
		yourself
]

{ #category : #accessing }
JRPCMessageObject >> id [
	^ id
]

{ #category : #accessing }
JRPCMessageObject >> id: anObject [
	id := anObject
]

{ #category : #initialization }
JRPCMessageObject >> initialize [
	super initialize.
	jsonrpc := JSONRPC
]

{ #category : #accessing }
JRPCMessageObject >> jsonrpc [
	^ jsonrpc
]

{ #category : #accessing }
JRPCMessageObject >> jsonrpc: anObject [
	jsonrpc := anObject
]
