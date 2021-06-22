Class {
	#name : #AMStudentTest,
	#superclass : #TestCase,
	#instVars : [
		'student'
	],
	#category : #'AmmoliteMagenta-Tests'
}

{ #category : #running }
AMStudentTest >> setUp [
	super setUp.
	
	student := AMStudent new.
	student name: 'toto'
]

{ #category : #tests }
AMStudentTest >> testInitialMarker [

	self deny: student markerP.
	self deny: student markerL
]

{ #category : #tests }
AMStudentTest >> testIsPresent [
	self assert: student isPresent
]

{ #category : #tests }
AMStudentTest >> testMarkerL [

	student marker: $-.
	self assert: student markerL.
	self deny: student markerP
]

{ #category : #tests }
AMStudentTest >> testMarkerP [

	student marker: $+.
	self assert: student markerP.
	self deny: student markerL
]

{ #category : #tests }
AMStudentTest >> testPrintOn [
	|str|
	str := WriteStream  on: String new.
	student printOn: str.
	self assert: str contents equals: student name
]
