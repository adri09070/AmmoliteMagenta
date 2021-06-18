Class {
	#name : #AMGroupBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'AmmoliteMagenta-Tests'
}

{ #category : #running }
AMGroupBuilderTest >> setUp [
	super setUp.
	
	builder := AMGroupBuilder new 
]

{ #category : #tests }
AMGroupBuilderTest >> testBuildGroupsSize [
	|groups|
	groups := builder buildGroups: 5 forStudents: ($a to: $z).
	self assert: groups size equals: 5
]
