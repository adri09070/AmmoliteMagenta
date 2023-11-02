Extension { #name : #Object }

{ #category : #'*AmmoliteMagenta-Benchmarks' }
Object >> haltOnCallTo: aSelector [

	^ VariableBreakpoint breakOn: aSelector inObject: self
]
