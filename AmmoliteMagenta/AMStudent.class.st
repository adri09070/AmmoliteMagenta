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
