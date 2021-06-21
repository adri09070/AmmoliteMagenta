"
I represent a promotion of students: 
- I have a name
- I have a list of students
"
Class {
	#name : #AMPromotion,
	#superclass : #Object,
	#instVars : [
		'name',
		'students'
	],
	#category : #'AmmoliteMagenta-model'
}

{ #category : #'instance creation' }
AMPromotion class >> readFromDisk [

	^ AMLocalRepository readAllPromotions collect: [ :association | 
		  | promotion |
		  promotion := self new.
		  promotion name: association key.
		  promotion students: (association value collect: [ :string | 
				   | workingString student endIndex |
				   workingString := string trimBoth.
				   student := AMStudent new.
				   endIndex := workingString size.
				   (#( $+ $- ) includes: workingString last) ifTrue: [ 
					   student marker: workingString last.
					   endIndex := workingString size - 1 ].
				   student name: (workingString copyFrom: 1 to: endIndex).
				   student ]).
		  promotion ]
]

{ #category : #accessing }
AMPromotion >> name [

	^ name
]

{ #category : #accessing }
AMPromotion >> name: anObject [

	name := anObject
]

{ #category : #accessing }
AMPromotion >> size [
	^self students size
]

{ #category : #accessing }
AMPromotion >> students [

	^ students ifNil: [ students := OrderedCollection new ]
]

{ #category : #accessing }
AMPromotion >> students: anObject [

	students := anObject
]
