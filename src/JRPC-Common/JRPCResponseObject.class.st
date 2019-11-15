"
I am an abstract response that can be returned by the server.
"
Class {
	#name : #JRPCResponseObject,
	#superclass : #JRPCMessageObject,
	#category : #'JRPC-Common-Core'
}

{ #category : #'server conversion' }
JRPCResponseObject >> beConvertedBy: aJRPCMessageProcessor [

	^ aJRPCMessageProcessor convertJRPCJsonableObjectToJSON: self asJRPCJSON
]

{ #category : #testing }
JRPCResponseObject >> isError [
	^ false
]
