Class {
	#name : #BaselineOfJRPC,
	#superclass : #BaselineOf,
	#category : #BaselineOfJRPC
}

{ #category : #baselines }
BaselineOfJRPC >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Packages"
			spec
				package: 'JRPC';
				package: 'JRPC-Tests' with: [ spec requires: #('JRPC') ] ]
]
