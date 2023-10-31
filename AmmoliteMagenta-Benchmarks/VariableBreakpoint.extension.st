Extension { #name : #VariableBreakpoint }

{ #category : #'*AmmoliteMagenta-Benchmarks' }
VariableBreakpoint >> breakInContext: aContext node: aNode [

	<debuggerCompleteToSender>
	self class notifyBreakpointHit: self inContext: aContext node: aNode.
	self isEnabled ifFalse: [ ^ self ].
	self onCount ifTrue: [
		self increaseCount = self breakOnCount ifFalse: [ ^ self ] ].
	self once ifTrue: [ self disable ].
	BreakWithoutStop break
]
