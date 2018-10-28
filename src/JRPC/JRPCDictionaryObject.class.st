"
I am an abstract class defining the fact that an object can be converted as a Dictionary.

My subclasses must define:
- #buildDictionary: which defines how to build a dictionary to represent the object.
- #fromDictionary: (class-side) which defines how to build an object from a dictionary representing it.
"
Class {
	#name : #JRPCDictionaryObject,
	#superclass : #Object,
	#pools : [
		'JRPCConstantsSharedPool'
	],
	#category : #'JRPC-Core'
}

{ #category : #'instance creation' }
JRPCDictionaryObject class >> fromDictionary: aDictionary [
	"Builds myself using keys/values defined in aDictionary.
	 Must be implemented by concrete subclasses.
	"
	^ self subclassResponsibility
]

{ #category : #converting }
JRPCDictionaryObject >> asDictionary [
	| dict |
	dict := Dictionary new.
	self buildDictionary: dict.
	^ dict
]

{ #category : #'dictionary building' }
JRPCDictionaryObject >> buildDictionary: aDictionary [
	"Insert into #aDictionary keys/values I need to insert."
	self subclassResponsibility
]
