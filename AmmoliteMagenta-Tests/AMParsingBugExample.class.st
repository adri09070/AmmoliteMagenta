Class {
	#name : #AMParsingBugExample,
	#superclass : #TestCase,
	#instVars : [
		'instrumenter'
	],
	#category : #'AmmoliteMagenta-Tests'
}

{ #category : #running }
AMParsingBugExample >> createPromotion [

	| promotion students |
	promotion := AMPromotion new.
	promotion name: 'OCRE xp'.

	students := (self students splitOn: Character cr) collect: [
		            :studentDataString |
		            | student |
		            student := AMStudent new.
		           	student data: studentDataString.
		            student ].
	promotion students: students.

	^ promotion
]

{ #category : #initialization }
AMParsingBugExample >> initialize [
	super initialize.
	instrumenter := [ :students :group| ]
]

{ #category : #accessing }
AMParsingBugExample >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #initialization }
AMParsingBugExample >> promotion [

	| promotion students |
	promotion := AMPromotion new.
	promotion name: 'OCRE xp'.

	students := (self students splitOn: Character cr) collect: [
		            :studentDataString |
		            | student readStream |
		            student := AMStudent new.
		            readStream := studentDataString readStream.
		            student name: (readStream upTo: Character space).
		            student marker: readStream upToEnd.
		            student ].
	promotion students: students.

	^ promotion
]

{ #category : #running }
AMParsingBugExample >> readPromotion: promotion [

	promotion students do: [ :student |
		| readStream |
		readStream := student data readStream.
		student name: (readStream upTo: Character space).
		student marker: readStream upToEnd ]
]

{ #category : #initialization }
AMParsingBugExample >> students [
	^'Nath -
Adèle +
William -
Marguerite +
Valérie -
Danielle -
Margot +
Diane +
Thibault -
Thomas +
Margaud -
Julie -
Charles-Thibault +
Alix +
Philippine -
Victoire -
Frédérique +
Adèle +
Constance +
Alex -
Isaac-Guillaume +
Élisabeth +
Guy -
Charles -
Raymond-Tristan 
Inès-Hélène +
Jean +
Alex +
Henri +
Jules -
Dorothée +
Alexandria +
Jacques -
Adèle + 
Catherine -'
]

{ #category : #running }
AMParsingBugExample >> testStudentPrinting [

	| group promotion students |
	group := AMGroup new.
	promotion := self createPromotion.
	students := promotion students.
	instrumenter value: students value: group.
	self readPromotion: promotion.
	students do: [ :s |
		| str |
		str := WriteStream on: String new.
		group textPrintStudent: s on: str.
		self assert: (#( $- $+ ) includes: str contents last) ]
]

{ #category : #running }
AMParsingBugExample >> testStudentSign [

	self assert: (self promotion students allSatisfy: [:s | s markerL or:[s markerP]]) 
]
