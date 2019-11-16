# Message Processing

JSON RCP messages are processed by instances of `JRPCMessageProcessor` independently of the underlying transport used for receiving and responding the messages.

The message processor has a list of method handlers available that will be searched when a incoming message is received. If a suitable handler is found (the `#methodName` is matching) then it gets executed with the parameters provided in the message.

A message processor can be configured using the following messages:
- `addHandlerNamed:block:`adds a new handler for a method that will evaluate the block provided as argument.
- `addHandlersFromPragmasIn:` searches for `<jrpc>` pragmas declared in the methods of the object provided as argument, and adds a message handler if such pragma is found. When such handler is added, the method in which the pragma was found is sent to the object when a matching JRPC message is received.
- `addHandler:` adds a new handler. Handlers must subclass `JRPCAbstractHandler`, this allows the end user to extend the available options if needed.

The message processor main API is `handleJSON:`, any server implementing a specific transport protocol must obtain the json string and delegate its processing by sending `handleJSON:` to the processor. `handleJSON:` method returns the JSON string to return to the client once the processing is completed.

## Message handlers

Message handlers are responsible of executing the code related to a JRPC method. All handlers are subclasses of `JRPCAbstractHandler` and need to provide a `methodName` and a way to execute this method with the provided arguments. There's two implementations already available `JRPCBlockHandler` and `JRPCPragmaHandler`.

- `JRPCBlockHandler` instances are created with a block closure that will be evaluated to compute the method. The parameter names are taken from the block parameters names.
- `JRPCPragmaHandler` instances will search for methods with the `<jrpc>` pragma. Subclasses must define `defaultMethodName` returning the name of the remote method to execute, and the code to be executed is the one in the method including the pragma. The parameter names are taken from the method including the pragma.
