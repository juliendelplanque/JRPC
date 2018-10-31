Class {
	#name : #JRPCServerScenarioTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Tests'
}

{ #category : #running }
JRPCServerScenarioTest >> setUp [
	super setUp.
	server := JRPCServer new.
	
	server
		addHandlerNamed: 'subtract' block: [ :minuend :subtrahend | minuend - subtrahend ];
		addHandlerNamed: 'update' block: [ :a :b :c :d :e | nil ]
]

{ #category : #tests }
JRPCServerScenarioTest >> testNotification [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response |
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "update", "params": [1,2,3,4,5]}'.
	self assert: response equals: ''.
	
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "foobar"}'.
	self assert: response equals: ''
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallBatch [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseArray responseObject |
	response := server handleJSON: '[
        {"jsonrpc": "2.0", "method": "sum", "params": [1,2,4], "id": "1"},
        {"jsonrpc": "2.0", "method": "notify_hello", "params": [7]},
        {"jsonrpc": "2.0", "method": "subtract", "params": [42,23], "id": "2"},
        {"foo": "boo"},
        {"jsonrpc": "2.0", "method": "foo.get", "params": {"name": "myself"}, "id": "5"},
        {"jsonrpc": "2.0", "method": "get_data", "id": "9"} 
    ]'.
	responseArray := STONJSON fromString: response.
	self assert: responseArray isArray.
	self assert: responseArray size equals: 5.
	
	responseObject := responseArray first.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: '1'.
	self assert: (responseObject at: 'result') equals: 7.
	
	responseObject := responseArray second.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: '2'.
	self assert: (responseObject at: 'result') equals: 19.
	
	responseObject := responseArray third.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: nil.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: InvalidRequest.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: InvalidRequest).
	
	responseObject := responseArray fourth.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: '5'.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: MethodNotFound.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: MethodNotFound).
	
	responseObject := responseArray fifth.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: '9'.
	self assert: (responseObject at: 'result') equals: #('hello' 5).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallBatchInvalidJSON [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '[
  {"jsonrpc": "2.0", "method": "sum", "params": [1,2,4], "id": "1"},
  {"jsonrpc": "2.0", "method"
]'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: nil.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: ParseError.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: ParseError).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallBatchWithAllNotifications [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response |
	response := server handleJSON: '[
        {"jsonrpc": "2.0", "method": "notify_sum", "params": [1,2,4]},
        {"jsonrpc": "2.0", "method": "notify_hello", "params": [7]}
    ]'.
	self assert: response equals: ''
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallOfNonExistentMethod [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "foobar", "id": "1"}'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	"Apparently, according to the example, since the id provided is a string, a string id is returned in the response..."
	self assert: (responseObject at: 'id') equals: '1'.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: MethodNotFound.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: MethodNotFound).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithAnEmptyArray [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '[]'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: nil.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: InvalidRequest.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: InvalidRequest).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithInvalidBatch [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseArray |
	response := server handleJSON: '[1,2,3]'.
	responseArray := STONJSON fromString: response.
	self assert: responseArray isArray.
	self assert: responseArray size equals: 3.
	responseArray do: [ :responseObject |
		self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
		self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
		self assert: (responseObject at: 'id') equals: nil.
		self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
		self assert: ((responseObject at: 'error') at: 'code') equals: InvalidRequest.
		self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: InvalidRequest) ].
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithInvalidJSON [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "foobar, "params": "bar", "baz]'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: nil.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: ParseError.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: ParseError).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithInvalidNotEmptyBatch [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseArray |
	response := server handleJSON: '[1]'.
	responseArray := STONJSON fromString: response.
	self assert: responseArray isArray.
	self assert: responseArray size equals: 1.
	self assertCollection: responseArray first keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseArray first at: 'jsonrpc') equals: '2.0'.
	self assert: (responseArray first at: 'id') equals: nil.
	self assertCollection: (responseArray first at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseArray first at: 'error') at: 'code') equals: InvalidRequest.
	self assert: ((responseArray first at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: InvalidRequest).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithInvalidRequest [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '{"jsonrpc": "2.0", "method": 1, "params": "bar"}'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'error' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: nil.
	self assertCollection: (responseObject at: 'error') keys hasSameElements: #('code' 'message').
	self assert: ((responseObject at: 'error') at: 'code') equals: InvalidRequest.
	self assert: ((responseObject at: 'error') at: 'message') equals: (JRPCConstantsSharedPool meaningForError: InvalidRequest).
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithNamedParameters [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "subtract", "params": {"subtrahend": 23, "minuend": 42}, "id": 3}'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: 3.
	self assert: (responseObject at: 'result') equals: 19.
	
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "subtract", "params": {"minuend": 42, "subtrahend": 23}, "id": 4}'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: 4.
	self assert: (responseObject at: 'result') equals: 19.
]

{ #category : #tests }
JRPCServerScenarioTest >> testRpcCallWithPositionalParameters [
	"Test built from example in Examples section of https://www.jsonrpc.org/specification"
	| response responseObject |
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "subtract", "params": [42, 23], "id": 1}'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: 1.
	self assert: (responseObject at: 'result') equals: 19.
	
	response := server handleJSON: '{"jsonrpc": "2.0", "method": "subtract", "params": [23, 42], "id": 2}'.
	responseObject := STONJSON fromString: response.
	self assertCollection: responseObject keys  hasSameElements: #('jsonrpc' 'result' 'id').
	self assert: (responseObject at: 'jsonrpc') equals: '2.0'.
	self assert: (responseObject at: 'id') equals: 2.
	self assert: (responseObject at: 'result') equals: -19.
]
