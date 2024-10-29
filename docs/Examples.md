# Examples
## Client
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

## Server
To create a server using HTTP protocol, listening on port 4000 and defining an handler for `'sqrt'` which computes the square-root of its single parameter, one can write the following:

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

## Additional data provided in error messages
[JSON-RPC 2.0 specification](https://www.jsonrpc.org/specification) specifies that in error messages, a `data` field can optionally be set to provide additional information about the error. However, this field structure is specified by the server. This section describes what the current implementation stores in the `data` field.

To do that, let's take the following configuration. We have a server defined as follow:
```Smalltalk
server := JRPCServer http
  port: 4000;
  addHandlerNamed: 'divide' block: [ :x :y | x / y ];
  yourself.

server start.
```

This server has a handler implenting a the division of `x` by `y`. In Pharo, dividing a `Number` by `0` results in a `ZeroDivide` error. Thus, the following code:

```Smalltalk
(JRPCClient http: 'http://localhost:4000')
	callMethod: 'divide' arguments: #(1 0) withId: 1.
```

Will results in a JSON-RPC error for which the error looks like this in JSON format:

```Smalltalk
{
	"jsonrpc" : "2.0",
	"id" : 1,
	"error" : {
		"data" : {
			"tag" : "",
			"errorClass" : "ZeroDivide",
			"signalerContext" : "SmallInteger>>/",
			"messageText" : "",
			"signaler" : "1"
		},
		"message" : "Internal JSON-RPC error.",
		"code" : -32603
	}
}
```

Mind the `data` sub-field inside `error` error field. It contains additional data about the error for which the structure is defined by this particular implementation.

The structure is the following:
```
{
  "errorClass" : String, // The class of the Pharo error.
  "signaler" : String, // The object to which the message was sent when the error occured.
  "signalerContext" : String, // The method in which error was raised formatted as Class>>method
  "messageText" : String, // The message the Pharo error hold.
  "tag" : String // The tag of the Pharo error.
}
```
