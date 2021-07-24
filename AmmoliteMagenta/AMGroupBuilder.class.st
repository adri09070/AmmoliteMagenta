"
I randomly build groups of students, given a number of groups and a list of students.
"
Class {
	#name : #AMGroupBuilder,
	#superclass : #Object,
	#category : #'AmmoliteMagenta-model'
}

{ #category : #'api - building' }
AMGroupBuilder >> buildGroups: n forStudents: studentList [

	| groups studentStack currentGroup |
	groups := LinkedList new.
	1 to: n do: [ :i | 
		| grp |
		grp := AMGroup new.
		grp id: i.
		groups add: grp ].

	studentStack := Stack new.
	studentList reverseDo: [ :name | 
		studentStack push: (AMStudent readFromString: name) ].

	currentGroup := groups firstLink.
	[ studentStack isEmpty ] whileFalse: [ 
		currentGroup value addStudent: studentStack pop.
		currentGroup := currentGroup nextLink ifNil: [ groups firstLink ] ].
	^ groups
]
