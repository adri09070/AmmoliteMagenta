"
I represent a group of students sorted by name.
"
Class {
	#name : #AMGroup,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'students'
	],
	#category : #AmmoliteMagenta
}

{ #category : #adding }
AMGroup >> addStudent: anAMStudent [
	self students add: anAMStudent
]

{ #category : #adding }
AMGroup >> students [

	^ students ifNil: [ 
		  students := SortedCollection sortBlock: [ :a :b | a name < b name ] ]
]
