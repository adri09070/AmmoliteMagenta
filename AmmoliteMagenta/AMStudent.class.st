"
I am a dumb model of a student, just representing the student by her name.
"
Class {
	#name : #AMStudent,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'AmmoliteMagenta-model'
}

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
	aStream << 'Student:'.
	aStream space.
	aStream << self name
]
