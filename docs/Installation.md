# Installation
- [Basic Installation](#basic-installation)
- [Using as dependency](#using-as-dependency)
- [Version management](#version-management)
- [Provided groups](#provided-groups)

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

## Version management

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`.

- **X** defines the major version number
- **Y** defines the minor version number
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases.

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Provided groups
- `Server-Deployment` will load all the packages needed to deploy a JSON RPC Message Processor
- `HTTP-Transport` will load all the packages needed to deploy an HTTP based JSON RPC Server
- `TCP-Transport` will load all the packages needed to deploy a TCP based JSON RPC Server
- `Client-Deployment` will load all the packages needed to deploy a JSON RPC Client
- `Deployment` will load all the packages needed to deploy both a JSON RPC Client and Server including HTTP and TCP transports
- `Tests` will load the test cases
- `CI` is the group loaded in the continuous integration setup
- `Development` will load all the needed packages to develop and contribute to the project

> Not specifying any group is equivalent to load `Development` group.
