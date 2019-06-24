Extension { #name : #ZnEntity }

{ #category : #'*JRPC-Server-Pharo6' }
ZnEntity class >> json: text [

	^ self stringEntityClass json: text
]
