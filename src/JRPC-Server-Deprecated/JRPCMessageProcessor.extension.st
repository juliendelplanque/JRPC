Extension { #name : #JRPCMessageProcessor }

{ #category : #'*JRPC-Server-Deprecated' }
JRPCMessageProcessor >> handlerForName: methodName [
	
	self deprecated: 'This method has been deprecated in favor of #handlerFor: that takes a request or a notificaiton as argument.
Thus, this method is not used internally by the message processor anymore.
This change was done to allow one to define handler that only deal with request or only with notification (it is still possible to deal with both and this is the default btw).
This method will be removed in next major version.'.
	methodName isString
		ifFalse: [ JRPCIncorrectJSON signal ].

	^ handlersByName at: methodName ifAbsent: [ JRPCNonExistentHandler signal: methodName ]
]
