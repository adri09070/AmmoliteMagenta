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

{ #category : #examples }
AMGroupBuilderPresenter class >> application [

	^ SpApplication new
		  styleSheet: self styleSheet;
		  yourself
]

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
	self basicNew
		application: self application;
		initialize;
		openWithSpec
]

{ #category : #specs }
AMGroupBuilderPresenter class >> outputLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #controls
				   expand: false
				   fill: false
				   padding: 5;
				   add: (SpBoxLayout newTopToBottom
						    add: 'Groups'
						    withConstraints: [ :constraints | constraints width: 50 ];
						    add: #nbGroupSelection
						    expand: false
						    fill: false
						    padding: 5;
						    yourself)
				   withConstraints: [ :constraints | constraints width: 60 ];
				   yourself)
		  withConstraints: [ :constraints | 
		  constraints height: self buttonHeight * 2 ];
	
		  yourself
]

{ #category : #examples }
AMGroupBuilderPresenter class >> styleSheet [

	^ SpStyleVariableSTONReader fromString: '
.application [
	Font { #name : EnvironmentFont(#default) },
	Geometry { #height: 25 },
	.box [ Geometry { #height: Reset, #vResizing: true, #hResizing: true } ],
	.label [
		Geometry { #hResizing: true, #height: 18 },
		.headerError [ Draw { #color:  #red }  ],
		.headerSuccess [ Draw { #color: #green } ],
		.header [ Draw { #color: Color{ #rgb: 622413393 } } ],
		.shortcut [ Draw { #color: Color{ #rgb: 622413393 } } ],
		.fixed [ Geometry { #hResizing: false, #width: 100 } ],
		.dim [ Draw { #color : Color{ #rgb: 708480675 } } ]
	],
	.link [ Geometry { #hResizing: true } ],
	.button [  
		Geometry { #width: 100, #height: 30 },
		.small [ Geometry { #width: 25, #height: 25 } ]
	],
	.checkBox [  
		Geometry { #hResizing: true },
		.compact [ Geometry { #hResizing: false, #width: 20 } ]
	],
	.radioButton [ Geometry { #hResizing: true } ],
	.dropList [ Geometry { #width: 150, #hResizing: true } ],
	.list [ Geometry { #width: 150, #minHeight: 125, #hResizing: true, #vResizing: true } ],
	.slider [ Geometry { #width: 150, #hResizing: true } ],
	.actionBar [  
		Container { #borderWidth: 0, #padding: 5 },
		Geometry { #width: 150, #height: 29, #hResizing: true, #vResizing: false }
	],
	.menuBar [ Geometry { #width: 150, #hResizing: true } ],
	.actionButton [  
		Geometry { #width: 70, #hResizing: false },
		.showIcon [ Geometry { #width: 25 } ]
	],
	.toolbar [ 
		Geometry { #height: Reset, #hResizing: true },
		.icons [ Geometry { #height: 30 } ],
		.iconsAndLabel [ Geometry { #height: 45 } ]
	],
	.text [ Geometry { #height: Reset }, Font { #size: 14 } ],
	.code [ Font { #name: EnvironmentFont(#code) } ],
	.codePopover [ 
		Draw { #color : #transparent },
		.button [ Geometry { #width : 25 } ]
	],
	.codePopoverError [ 
		Draw { #backgroundColor: #C20000 },
		Font { #color: #white } 
	],
	.scrollbarPopoverLarge [ Geometry { #height: 350 } ],
	.popover [
		.print [ Draw { #color: EnvironmentColor(#balloonBackground) } ],
		.error [ Draw { #color: #C20000 } ],
		.popoverButton [ Draw { #color: EnvironmentColor(#popoverButton) } ] ],
	.paginator [ Geometry { #height: 20 } ],
	.morph [ Geometry { #width: Reset, #height: Reset, #vResizing: true, #hResizing: true } ],
	.image [ Geometry { #width: Reset, #height: Reset, #vResizing: true, #hResizing: true } ] ]
'
]

{ #category : #updating }
AMGroupBuilderPresenter >> clearGroups [
	self flag: 'todo'
]

{ #category : #displaying }
AMGroupBuilderPresenter >> displayGroups: groups [

	| grid str i j lay |
	grid := SpGridLayout new.
	grid borderWidth: 0.
	grid beRowHomogeneous.
	
	i := 1.
	j := 1.

	groups do: [ :g | 
		| text |
		text := SpTextPresenter new.
		text beNotEditable.
		str := WriteStream on: Text new.
		g textPrintOn: str.
		text text: str contents.
		grid add: text at: i @ j.
	
		i := i + 1.
		i > 4 ifTrue: [ 
			j := j + 1.
			i := 1 ] ].

	1 to: j do:[:n| grid row: n withConstraints: [ :c | c beExpand ]].
	lay := self class defaultSpec.
	lay children second add: grid expand: true fill: true padding: 0.
	self layout: lay
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

	aWindowPresenter maximize.
	aWindowPresenter title: 'Ammolite Magenta'.
	"aWindowPresenter withoutDecorations"
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
