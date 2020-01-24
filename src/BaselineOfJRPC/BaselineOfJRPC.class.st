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
BaselineOfJRPC >> setUpClientDeploymentPackages: spec [

	spec
		package: 'JRPC-Client' with: [ spec requires: 'JRPC-Common' ];
		group: 'Client-Deployment' with: 'JRPC-Client'.
]

{ #category : #baselines }
BaselineOfJRPC >> setUpPackages: spec [

	spec package: 'JRPC-Common'.
	self
		setUpServerDeploymentPackages: spec;
		setUpClientDeploymentPackages: spec.

	spec
		group: 'Deployment'
		with: #('Server-Deployment' 'HTTP-Transport' 'TCP-Transport' 'Client-Deployment' 'JRPC-Server-Deprecated').
		
	spec
		group: 'Development'
		with: #('Deployment' 'Server-Logging').

	spec
		package: 'JRPC-Tests' with: [ spec requires: 'Deployment' ];
		group: 'Tests' with: 'JRPC-Tests'
]

{ #category : #baselines }
BaselineOfJRPC >> setUpServerDeploymentPackages: spec [

	spec
		for: #'pharo6.x'
		do: [ spec
				package: 'JRPC-Server-Pharo6';
				group: 'Server-Deployment' with: 'JRPC-Server-Pharo6'
			].
	spec
		package: 'JRPC-Server-Core' with: [ spec requires: 'JRPC-Common' ];
		group: 'Server-Deployment' with: 'JRPC-Server-Core'.

	spec
		package: 'JRPC-Server-HTTP' with: [ spec requires: 'JRPC-Server-Core' ];
		group: 'HTTP-Transport' with: 'JRPC-Server-HTTP'.

	spec
		package: 'JRPC-Server-TCP' with: [ spec requires: 'JRPC-Server-Core' ];
		group: 'TCP-Transport' with: 'JRPC-Server-TCP'.
		
	spec
		package: 'JRPC-Server-Logging' with: [ spec requires: 'JRPC-Server-Core' ];
		group: 'Server-Logging' with: 'JRPC-Server-Logging'.
		
	spec
		package: 'JRPC-Server-Deprecated' with: [ spec requires: 'JRPC-Server-Core' ]
]
