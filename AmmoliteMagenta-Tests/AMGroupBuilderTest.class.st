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
AMGroupBuilderTest >> testBuildGroupsIds [

	| groups |
	groups := builder buildGroups: 5 forStudents: ($a to: $z).
	self assert: groups first id equals: 1.
	self assert: groups second id equals: 2.
	self assert: groups third id equals: 3.
	self assert: groups fourth id equals: 4.
	self assert: groups fifth id equals: 5
]

{ #category : #tests }
AMGroupBuilderTest >> testBuildGroupsSize [
	|groups|
	groups := builder buildGroups: 5 forStudents: ($a to: $z).
	self assert: groups size equals: 5
]
