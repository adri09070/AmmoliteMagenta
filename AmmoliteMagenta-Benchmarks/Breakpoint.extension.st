Extension { #name : #Breakpoint }

{ #category : #'*AmmoliteMagenta-Benchmarks' }
Breakpoint >> breakInContext: aContext node: aNode [

	<debuggerCompleteToSender>
	self class notifyBreakpointHit: self inContext: aContext node: aNode.
	self isEnabled ifFalse: [ ^ self ].
	self onCount ifTrue: [
		self increaseCount = self breakOnCount ifFalse: [ ^ self ] ].
	self once ifTrue: [ self disable ].
	self isObjectCentric
		ifFalse: [ Break break ]
		ifTrue: [ BreakWithoutStop break ]
]
