Extension { #name : #ZnStringEntity }

{ #category : #'*JRPC-Server-Pharo6' }
ZnStringEntity class >> json: string [
	^ (self type: ZnMimeType applicationJson)
		string: string;
		yourself
]
