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
AMGroupBuilderTest >> testBuildGroupsRepartition [
	|groups testBlock|
	groups := builder buildGroups: 5 forStudents: (($a to: $z) collect:[:letter| letter asString]).
	testBlock := [ :names :group :size|
		self assert: group students size equals: size.
		self assert: group students first name equals: names first.
		self assert: group students second name equals: names second.
		self assert: group students third name equals: names third.
		self assert: group students fourth name equals: names fourth.
		self assert: group students fifth name equals: names fifth ].
	
	testBlock value: #('a' 'f' 'k' 'p' 'u' 'z') value: groups first value: 6.
	testBlock value: #('b' 'g' 'l' 'q' 'v') value: groups second value: 5.
	testBlock value: #('c' 'h' 'm' 'r' 'w') value: groups third value: 5.
	testBlock value: #('d' 'i' 'n' 's' 'x') value: groups fourth value: 5.
	testBlock value: #('e' 'j' 'o' 't' 'y') value: groups fifth value: 5
]

{ #category : #tests }
AMGroupBuilderTest >> testBuildGroupsSize [
	|groups|
	groups := builder buildGroups: 5 forStudents: ($a to: $z).
	self assert: groups size equals: 5
]
