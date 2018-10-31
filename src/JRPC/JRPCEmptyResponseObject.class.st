"
I am an empty response that is returned in the case of the process of a notification.
"
Class {
	#name : #JRPCEmptyResponseObject,
	#superclass : #JRPCResponseObject,
	#category : #'JRPC-Core'
}

{ #category : #converting }
JRPCEmptyResponseObject >> asJRPCJSON [
	"To be removed from array built in case of a batch."
	^ nil
]

{ #category : #'server conversion' }
JRPCEmptyResponseObject >> beConvertedBy: aJRPCServer [
	"Nothing should be returned by the server."
	^ ''
]
