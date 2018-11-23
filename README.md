# JRPC [![Build Status](https://travis-ci.org/juliendelplanque/JRPC.svg?branch=master)](https://travis-ci.org/juliendelplanque/JRPC)
Yet another JSON-RPC 2.0 implementation for Pharo Smalltalk

## Features
- Client and Server support for JSON-RPC 2.0.
- Only depends on Pharo's built-in packages.
- Uses STONJSON to parse JSON internally.
- Transport agnostic (like JSON-RPC 2.0 spec claims).
- Can currently be used over HTTP but easily extendable.

## Examples
### Client
Given a server using HTTP protocol, listening on port 4000 and exposing `'sqrt'` method which computes the square-root of its single parameter, one can write the following:

```Smalltalk
(JRPCClient http: 'http://localhost:4000')
	callMethod: 'sqrt' arguments: #(4) withId: 1
```

The object returned by this expression is an instance of `JRPCSuccessResponseObject`.
Its `result` instance variable contains the result of `sqrt` method applied on `4`. That is to say, it contains `2.0`.
Its `id` instance variable contains the `id` specified previously.

Ids allow to map responses returned by the server to requests sent by the client.
Ids are managed by the developer using the client.

### Server
To create a server using HTTP protocol, listening on port 4000 and defining an handler for `'sqrt'` which computes the square-root of its single paramter, one can write the following:

```Smalltalk
server := JRPCServer http
		port: 4000;
		addHandlerNamed: 'sqrt' block: [ :x | x sqrt ];
		yourself.
```

To start it, use `#start` method:

```Smalltalk
server start
```

To stop it, use `#stop` method:

```Smalltalk
server stop
```

## Version management 

This project use semantic versionning to define the releases. This mean that each stable release of the project will get associate a version number of the form `vX.Y.Z`. 

- **X** define the major version number
- **Y** define the minor version number 
- **Z** define the patch version number

When a release contains only bug fixes, the patch number increase. When the release contains new features backward compatibles, the minor version increase. When the release contains breaking changes, the major version increase. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Install
To install this project, run the following code snippet:
```Smalltalk
Metacello new
    repository: 'github://JulienDelplanque/JRPC/src';
    baseline: 'JRPC';
    load
```
