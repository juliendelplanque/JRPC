Class {
	#name : #JRPCExampleStack,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'JRPC-Tests'
}

{ #category : #initialization }
JRPCExampleStack >> initialize [
	super initialize.
	stack := Stack new.
]

{ #category : #removing }
JRPCExampleStack >> pop [
	<jrpc: #stack_pop>
	^ stack pop
]

{ #category : #removing }
JRPCExampleStack >> push: anObject [
	<jrpc: #stack_push>
	stack push: anObject.
	"We return nil explicitely, else as the default behaviour is to return self,
	 it will result in a server error.
	 It is possible to let a method exposed as a JRPC procedure return self but,
	 in this case, the object must implement #asJRPCJSON to return a json object.
	"
	^ nil
]

{ #category : #removing }
JRPCExampleStack >> top [
	<jrpc: #stack_top>
	^ stack top
]
