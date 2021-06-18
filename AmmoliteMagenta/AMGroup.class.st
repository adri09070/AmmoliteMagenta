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
	#category : #'AmmoliteMagenta-model'
}

{ #category : #adding }
AMGroup >> addStudent: anAMStudent [
	self students add: anAMStudent
]

{ #category : #accessing }
AMGroup >> id [

	^ id
]

{ #category : #accessing }
AMGroup >> id: anInteger [ 
	id := anInteger
]

{ #category : #adding }
AMGroup >> students [

	^ students ifNil: [ 
		  students := SortedCollection sortBlock: [ :a :b | a name < b name ] ]
]