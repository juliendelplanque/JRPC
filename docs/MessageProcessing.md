# Message Processing

JSON RCP messages are processed by instances of `JRPCMessageProcessor` independently of the underlying transport used for receiving and responding the messages.

The message processor has available a list of method handlers that will be searched when a incoming message is received, if a suitable handler is found then it gets executed with the parameters provided in the message.

To configure a message processor use any of the following messages to add new handlers:
- `addHandlerNamed:block:` will add a new handler for a method that will evaluate the provided block
- `addHandlersFromPragmasIn:` will search for `<jrpc>` pragmas declared in the methods of the parameter object, and will add a message handler if found.
- `addHandler:` will add a new handler. Handlers must subclass `JRPCAbstractHandler`, this allows the end user to extend the available options if needed.

The message processor main API is `handleJSON:` , any server implementing an specific transport protocol must obtain the json string and delegate it's processing by sending this message and will receive the json string to be used as response.

## Message handlers

Message handlers are responsible of executing the code related to a method. All handlers are subclasses of `JRPCAbstractHandler` and need to provide a `methodName` and a way to execute this method with the provided arguments. There's two implementations already available `JRPCBlockHandler` and `JRPCPragmaHandler`.

- `JRPCBlockHandler` instances are created with a block closure that will we evaluated to compute the method. The parameter names are taken from the block.
- `JRPCPragmaHandler` instances will search for methods with the `<jrpc>` pragma. Subclasses must define `defaultMethodName` returning the name of the remote method to execute, and the code to be executed is the one in the method including the pragma. The parameter names are taken from the method including the pragma.
