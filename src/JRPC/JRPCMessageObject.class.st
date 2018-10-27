Class {
	#name : #JRPCMessageObject,
	#superclass : #JRPCDictionaryObject,
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
				ifTrue: [ ^ JRPCErrorResponseObject ] ].
	
	JRPCIncorrectJSON signal: 'Incorrect JSON, no class to instantiate for it.'
]

{ #category : #'instance creation' }
JRPCMessageObject class >> fromDictionary: aDictionary [
	^ self new
		jsonrpc: (aDictionary at: 'jsonrpc');
		id: (aDictionary at: 'id');
		yourself
]

{ #category : #'dictionary building' }
JRPCMessageObject >> buildDictionary: aDictionary [
	aDictionary
		at: 'jsonrpc' put: self jsonrpc;
		at: 'id' put: self id
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
