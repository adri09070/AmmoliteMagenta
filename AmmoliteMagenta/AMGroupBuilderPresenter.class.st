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
		'output',
		'nbGroupSelection'
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

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight  add: #controls  expand: false fill: false padding: 5;
				   add: (SpBoxLayout newTopToBottom
						    add: 'Groups' withConstraints: [ :constraints | constraints width: 50 ];
						    add: #nbGroupSelection expand: false fill: false padding: 5; 
						    yourself) withConstraints: [ :constraints | constraints width: 60 ];
				   yourself)  withConstraints: [ :constraints | constraints height: self buttonHeight * 2 ];
					
		  add: #output;
		  yourself
]

{ #category : #updating }
AMGroupBuilderPresenter >> clearGroups [
	self flag: 'todo'
]

{ #category : #displaying }
AMGroupBuilderPresenter >> displayGroups: groups [

	| str |
	str := WriteStream on: Text new.
	groups do: [ :g | g textPrintOn: str ].
	output text: str contents
]

{ #category : #actions }
AMGroupBuilderPresenter >> exit [
	Smalltalk snapshot: true andQuit: true 
]

{ #category : #export }
AMGroupBuilderPresenter >> exportGroups: groups [

	| str |
	str := self newGeneratedGroupFileReference writeStream.
	groups do: [ :g | g textPrintOn: str ].
	str close
]

{ #category : #actions }
AMGroupBuilderPresenter >> generate [

	| nbGroups studentsSelection groups |
	self isPromotionSelected ifFalse: [ ^ self ].
	nbGroups := nbGroupSelection selectedItem.

	studentsSelection := classes selectedItem students select: [ :s | 
		                     s isPresent ].
	groups := AMGroupBuilder new
		          buildGroups: nbGroups
		          forStudents: studentsSelection.
	self displayGroups: groups.
	self exportGroups: groups
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
	nbGroupSelection := self newDropList.
	nbGroupSelection items: (2 to: 12) asArray.
	
	output := self newText.
	output beNotEditable.
	
	classes items: AMPromotion readFromDisk 
]

{ #category : #initialization }
AMGroupBuilderPresenter >> initializeToolbar [

	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Exit';
			 icon: (self iconNamed: #smallQuit);
			 help: 'Exits program';
			 action: [ self exit ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Reload';
			 icon: (self iconNamed: #refresh);
			 help: 'Reload data from disk';
			 action: [ self reload ];
			 yourself).
	
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Pick';
			 icon: (self iconNamed: #smallNew);
			 help: 'Picks a random student in the selected promotion';
			 action: [ self pickRandomStudent ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Generate';
			 icon: (self iconNamed: #group);
			 help: 'Generate student groups';
			 action: [ self generate ];
			 yourself)
]

{ #category : #initialization }
AMGroupBuilderPresenter >> initializeWindow: aWindowPresenter [
	
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Ammolite Magenta'
]

{ #category : #testing }
AMGroupBuilderPresenter >> isPromotionSelected [

	| promotion |
	promotion := classes selectedItem.
	promotion ifNil: [ 
		self warning: 'No promotion selected' relativeTo: classes.
		^ false ].
	^ true
]

{ #category : #export }
AMGroupBuilderPresenter >> newGeneratedGroupFileReference [

	| str dateTime |
	str := WriteStream on: String new.
	str << classes selectedItem name.
	str << '_'.
	dateTime := DateAndTime now.
	dateTime printYMDOn: str.
	str << '_'.
	dateTime printHMSWithDashesOn: str.
	str << '.txt'.
	^ str contents asFileReference
]

{ #category : #actions }
AMGroupBuilderPresenter >> pickRandomStudent [

	self isPromotionSelected ifFalse: [ ^ self ].
	output text: classes selectedItem pickRandomStudent printString
]

{ #category : #actions }
AMGroupBuilderPresenter >> reload [
	classes items: AMPromotion readFromDisk.
	classes unselectAll.
	students unselectAll 
	
]

{ #category : #updating }
AMGroupBuilderPresenter >> updateStudents: class [

	students items: class students
]

{ #category : #ui }
AMGroupBuilderPresenter >> warning: aString relativeTo: aPresenter [ 
	self newPopover
		addStyle: 'error';
		relativeTo: aPresenter;
		position: SpPopoverPosition top;
		presenter: (SpPresenter new
				 layout: (SpBoxLayout newTopToBottom
						  borderWidth: 2;
						  spacing: 0;
						  add: (self newLabel label: aString);
						  yourself);
				 yourself);
		popup
]
