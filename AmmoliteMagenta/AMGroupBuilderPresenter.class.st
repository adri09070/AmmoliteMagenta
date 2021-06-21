"
I am the Ammolite Magenta application.
I allow for creating and shuffling groups of students.
"
Class {
	#name : #AMGroupBuilderPresenter,
	#superclass : #StPresenter,
	#instVars : [
		'classes',
		'students',
		'controls',
		'output'
	],
	#category : #'AmmoliteMagenta-presenters'
}

{ #category : #specs }
AMGroupBuilderPresenter class >> configurationLayout [

	^ SpBoxLayout newLeftToRight
		  add: #classes;
		  add: #students;
		  yourself
]

{ #category : #specs }
AMGroupBuilderPresenter class >> defaultSpec [

	^ SpPanedLayout newTopToBottom
		positionOfSlider: 30 percent;
		add: self configurationLayout;
		add: self outputLayout;
		yourself
]

{ #category : #examples }
AMGroupBuilderPresenter class >> example [
	<script>
	self new openWithSpec
]

{ #category : #specs }
AMGroupBuilderPresenter class >> outputLayout [
	^SpBoxLayout newTopToBottom
		add: #controls	expand: false fill: false padding: 5;
		add: #output;
		yourself
]

{ #category : #updating }
AMGroupBuilderPresenter >> clearGroups [
	self flag: 'todo'
]

{ #category : #initialization }
AMGroupBuilderPresenter >> initializePresenters [ 
	
	super initializePresenters.
	classes := self newTable.
	classes addColumn: (SpStringTableColumn title: 'Class' evaluated: #name).
	classes addColumn: ((SpStringTableColumn title: 'Number of students' evaluated: #size) width: 150; yourself).
	classes transmitDo: [ :class | 
		class ifNotNil:[ 
			self updateStudents: class.
			self clearGroups ] ].
		
	students := self newTable.
	students addColumn: ((SpCheckBoxTableColumn title: ' ' evaluated: [ :student | student isPresent])
				onActivation: [ :student | student isPresent: true];
				onDeactivation: [ :student | student isPresent: false];
				width: 20;
				yourself).
	students addColumn: (SpStringTableColumn title: 'Student' evaluated: #name).
	
	controls := self newToolbar.
	self initializeToolbar.
	
	output := self newText.
	
	classes items: AMPromotion readFromDisk 
]

{ #category : #initialization }
AMGroupBuilderPresenter >> initializeToolbar [

	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Reload';
			 icon: (self iconNamed: #refresh);
			 help: 'Reload data from disk';
			 action: [ self inform: 'Ok' ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Reshuffle';
			 icon: (self iconNamed: #smallUpdate);
			 help: 'Reshuffle the student list';
			 action: [ self inform: 'Ok' ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Generate';
			 icon: (self iconNamed: #forward);
			 help: 'Generate student groups';
			 action: [ self inform: 'Ok' ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Exit';
			 icon: (self iconNamed: #smallQuit);
			 help: 'Exits program';
			 action: [ self inform: 'Ok' ];
			 yourself)
]

{ #category : #initialization }
AMGroupBuilderPresenter >> initializeWindow: aWindowPresenter [
	
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Ammolite Magenta'
]

{ #category : #updating }
AMGroupBuilderPresenter >> updateStudents: class [

	students items: class students
]
