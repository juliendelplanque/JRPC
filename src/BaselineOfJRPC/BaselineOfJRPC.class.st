Class {
	#name : #BaselineOfJRPC,
	#superclass : #BaselineOf,
	#category : #BaselineOfJRPC
}

{ #category : #baselines }
BaselineOfJRPC >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self setUpPackages: spec.
			spec
				group: 'CI' with: 'Tests';
				group: 'Development' with: 'Tests'
			]
]

{ #category : #accessing }
BaselineOfJRPC >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfJRPC >> setUpPackages: spec [

	spec package: 'JRPC-Common'.
	spec
		package: 'JRPC-Server' with: [ spec requires: 'JRPC-Common' ];
		group: 'Server-Deployment' with: 'JRPC-Server'.
	spec
		package: 'JRPC-Client' with: [ spec requires: 'JRPC-Common' ];
		group: 'Client-Deployment' with: 'JRPC-Client'.
	spec group: 'Deployment' with: #('Server-Deployment' 'Client-Deployment').

	spec
		package: 'JRPC-Tests' with: [ spec requires: 'Deployment' ];
		group: 'Tests' with: 'JRPC-Tests'
]
