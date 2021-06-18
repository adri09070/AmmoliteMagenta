"
I randomly build groups of students, given a number of groups and a list of students.
"
Class {
	#name : #AMGroupBuilder,
	#superclass : #Object,
	#category : #AmmoliteMagenta
}

{ #category : #'api - building' }
AMGroupBuilder >> buildGroups: n forStudents: studentList [

	| groups studentStack currentGroup |
	groups := LinkedList new.
	n timesRepeat: [ groups add: AMGroup new ].
	"groups lastLink nextLink: groups firstLink."

	studentStack := Stack new.
	studentList do: [ :name | 
		studentStack push: (AMStudent new name: name) ].

	currentGroup := groups firstLink.
	[ studentStack isEmpty ] whileFalse: [ 
		currentGroup value addStudent: studentStack pop.
		currentGroup := currentGroup nextLink ifNil: [ groups firstLink ] ].
	^ groups
]
