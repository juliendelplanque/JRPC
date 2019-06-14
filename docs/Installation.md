# Installation

## Basic Installation

You can load **JRPC** evaluating:
```smalltalk
Metacello new
	baseline: 'JRPC';
	repository: 'github://juliendelplanque/JRPC:master/src';
	load.
```
>  Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **JRPC** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: 'JRPC'
			with: [ spec
				repository: 'github://juliendelplanque/JRPC:v{XX}/src';
				loads: #('Deployment') ];
		import: 'JRPC'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('JRPC') ] ]
```

## Provided groups
- `Server-Deployment` will load all the packages needed to deploy a JSON RPC Server
- `Client-Deployemnt` will load all the packages needed to deploy a JSON RPC Client
- `Deployment` will load all the packages needed to deploy both a JSON RPC Client and Server
- `Tests` will load the test cases
- `CI` is the group loaded in the continuous integration setup
- `Development` will load all the needed packages to develop and contribute to the project
