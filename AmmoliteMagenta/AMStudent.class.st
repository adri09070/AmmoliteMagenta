"
I am a dumb model of a student, just representing the student by her name.
"
Class {
	#name : #AMStudent,
	#superclass : #Object,
	#instVars : [
		'name',
		'marker',
		'isPresent'
	],
	#category : #'AmmoliteMagenta-model'
}

{ #category : #api }
AMStudent class >> markerL [

	^ $-
]

{ #category : #api }
AMStudent class >> markerP [

	^ $+
]

{ #category : #api }
AMStudent class >> markers [

	^ Array with: self markerP with: self markerL
]

{ #category : #reading }
AMStudent class >> readFromString: aString [

	| student workingString endIndex |
	student := self new.
	workingString := aString trimBoth.
	endIndex := workingString size.
	(self markers includes: workingString last) ifTrue: [ 
		student marker: workingString last.
		endIndex := workingString size - 1 ].
	student name: (workingString copyFrom: 1 to: endIndex) trimBoth.
	^ student
]

{ #category : #accessing }
AMStudent >> isPresent [

	^ isPresent ifNil: [ isPresent := true ]
]

{ #category : #accessing }
AMStudent >> isPresent: anObject [

	isPresent := anObject
]

{ #category : #accessing }
AMStudent >> marker [

	^ marker
]

{ #category : #accessing }
AMStudent >> marker: anObject [

	marker := anObject
]

{ #category : #api }
AMStudent >> markerL [

	^ marker = $-
]

{ #category : #api }
AMStudent >> markerP [

	^ marker = $+
]

{ #category : #accessing }
AMStudent >> name [

	^ name
]

{ #category : #accessing }
AMStudent >> name: anObject [

	name := anObject
]

{ #category : #printing }
AMStudent >> printOn: aStream [

	aStream << self name
]
