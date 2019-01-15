Class {
	#name : #JRPCStreamClient,
	#superclass : #JRPCClient,
	#instVars : [
		'writeStream',
		'readStream',
		'requestsSeparator',
		'actionAfterStreamWritten'
	],
	#category : #'JRPC-Clients'
}

{ #category : #'instance creation' }
JRPCStreamClient class >> writeStream: writeStream readStream: readStream requestsSeparator: aString [
	^ self new
		writeStream: writeStream;
		readStream: readStream;
		requestsSeparator: aString;
		yourself
]

{ #category : #accessing }
JRPCStreamClient >> actionAfterStreamWritten [
	^ actionAfterStreamWritten
]

{ #category : #accessing }
JRPCStreamClient >> actionAfterStreamWritten: anObject [
	actionAfterStreamWritten := anObject
]

{ #category : #initialization }
JRPCStreamClient >> initialize [
	super initialize.
	self actionAfterStreamWritten: [  ]
]

{ #category : #accessing }
JRPCStreamClient >> readStream [
	^ readStream
]

{ #category : #accessing }
JRPCStreamClient >> readStream: anObject [
	readStream := anObject
]

{ #category : #accessing }
JRPCStreamClient >> requestsSeparator [
	^ requestsSeparator
]

{ #category : #accessing }
JRPCStreamClient >> requestsSeparator: anObject [
	requestsSeparator := anObject
]

{ #category : #'private - sending' }
JRPCStreamClient >> sendRequest: aJRPCRequestObject [
	self convertJRPCJsonableObjectToJSON: aJRPCRequestObject asJRPCJSON on: self writeStream.
	self writeStream
		nextPutAll: self requestsSeparator.
		
	self actionAfterStreamWritten cull: self writeStream.
	
	"Needs to parse from a String here because it is possible that the stream
	 provided can not do look ahead (the JSON parser needs that)."
	^ self parseSupposedJRPCMessageObjectFromString: self readStream upToEnd
]

{ #category : #accessing }
JRPCStreamClient >> writeStream [
	^ writeStream
]

{ #category : #accessing }
JRPCStreamClient >> writeStream: anObject [
	writeStream := anObject
]
