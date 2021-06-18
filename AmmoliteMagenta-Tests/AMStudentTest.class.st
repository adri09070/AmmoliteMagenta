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
AMStudentTest >> testPrintOn [
	|str|
	str := WriteStream  on: String new.
	student printOn: str.
	self assert: str contents equals: 'Student: ', student name
]
