"
I am a shared pool holding constants defined by JSON-RPC 2.0 spec [1].

[1]: https://www.jsonrpc.org/specification
"
Class {
	#name : #JRPCConstantsSharedPool,
	#superclass : #SharedPool,
	#classVars : [
		'ErrorCodesToMeaningDict',
		'InternalError',
		'InvalidParams',
		'InvalidRequest',
		'JSONRPC',
		'MethodNotFound',
		'ParseError'
	],
	#category : #'JRPC-Common-Core'
}

{ #category : #initialization }
JRPCConstantsSharedPool class >> initialize [
	self initializeErrorCodes.
	self initializeErrorCodesToMeaningDict.
	self initializeJSONRPCVersionConstant
]

{ #category : #initialization }
JRPCConstantsSharedPool class >> initializeErrorCodes [
	ParseError := -32700.
	InvalidRequest := -32600.
	MethodNotFound := -32601.
	InvalidParams := -32602.
	InternalError := -32603.
]

{ #category : #initialization }
JRPCConstantsSharedPool class >> initializeErrorCodesToMeaningDict [
	ErrorCodesToMeaningDict := { 
		ParseError     -> 'Invalid JSON was received by the server.'.
		InvalidRequest -> 'The JSON sent is not a valid Request object.'.
		MethodNotFound -> 'The method does not exist / is not available.'.
		InvalidParams  -> 'Invalid method parameter(s).'.
		InternalError  -> 'Internal JSON-RPC error.' } asDictionary
]

{ #category : #initialization }
JRPCConstantsSharedPool class >> initializeJSONRPCVersionConstant [
	JSONRPC := '2.0'
]

{ #category : #accessing }
JRPCConstantsSharedPool class >> meaningForError: anInteger [
	^ ErrorCodesToMeaningDict at: anInteger
]
