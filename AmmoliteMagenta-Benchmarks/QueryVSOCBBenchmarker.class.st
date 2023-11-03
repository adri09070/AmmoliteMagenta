Class {
	#name : #QueryVSOCBBenchmarker,
	#superclass : #Object,
	#instVars : [
		'seekerDebugger',
		'querySolver',
		'oid',
		'sindarinDebugger',
		'normalTimes',
		'ocbTimesOneVarRead',
		'ocbTimesOneVarWrite',
		'ocbTimesOneVarReadWrite',
		'ocbTimesAllVarsRead',
		'ocbTimesAllVarsWrite',
		'ocbTimesAllVarsReadWrite',
		'ocbTimesMethodCall',
		'ttqTimesOneVarRead',
		'ttqTimesOneVarWrite',
		'ttqTimesAllVarsRead',
		'ttqTimesAllVarsWrite',
		'ttqTimesMethodCall',
		'ttqTimesOneVarReadUncached',
		'ttqTimesOneVarWriteUncached',
		'ttqTimesAllVarsReadUncached',
		'ttqTimesAllVarsWriteUncached',
		'ttqTimesMethodCallUncached',
		'objectOfInterest',
		'result',
		'instrumentationTime'
	],
	#category : #'AmmoliteMagenta-Benchmarks'
}

{ #category : #benchmarking }
QueryVSOCBBenchmarker class >> benchmark [

	<script>
	self new
		benchmark;
		inspect
]

{ #category : #adding }
QueryVSOCBBenchmarker >> addBenchmarkResultNamed: benchName withPharoTimes: pharoTimes withOcbTimes: ocbTimes withTTQCachedTimes: ttqCachedTimes withTTQUncachedTimes: ttqUncachedTimes [

	result
		addResult: (OCBVSTTQBenchmarkResult
				 computeResultNamed: benchName
				 withPharo: pharoTimes
				 withOcb: ocbTimes
				 withTTQCached: ttqCachedTimes
				 withTTQUncachedTimes: ttqUncachedTimes)
		named: benchName
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmark [

	self benchmarkNormalTimes.

	self benchmarkOCBOneVarRead.

	self benchmarkOCBOneVarWrite.

	self benchmarkOCBOneVarReadWrite.

	self benchmarkOCBAllVarsRead.

	self benchmarkOCBAllVarsWrite.

	self benchmarkOCBAllVarsReadWrite.

	self benchmarkOCBMethodCall.

	self benchmarkTTQOneVarRead.

	self benchmarkTTQOneVarWrite.

	self benchmarkTTQAllVarsRead.

	self benchmarkTTQAllVarsWrite.

	self benchmarkTTQMethodCall.

	self computeBenchmarkResult
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkNormalTimes [

	30 timesRepeat: [
		normalTimes add:
			(self exampleCodeinstrumenter: [ :students :group |  ])
				timeToRunWithoutGC ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsRead [

	30 timesRepeat: [
		| student |
		MetaLink uninstallAll.
		student := AMStudent new.
		instrumentationTime := [ student haltOnRead ] timeToRunWithoutGC.
		MetaLink uninstallAll.
		
		ocbTimesAllVarsRead add:
			(self exampleCodeinstrumenter: [ :students :group |
				 students first haltOnRead ]) timeToRunWithoutGC
			- instrumentationTime ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsReadWrite [

	30 timesRepeat: [
		| student |
		MetaLink uninstallAll.
		student := AMStudent new.
		instrumentationTime := [ student haltOnAccess ] timeToRunWithoutGC.
		MetaLink uninstallAll.
		
		ocbTimesAllVarsReadWrite add:
			(self exampleCodeinstrumenter: [ :students :group |
				 students first haltOnAccess ]) timeToRunWithoutGC - instrumentationTime  ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsWrite [

	30 timesRepeat: [
		| student |
		MetaLink uninstallAll.
		student := AMStudent new.
		instrumentationTime := [ student haltOnWrite ] timeToRunWithoutGC.
		MetaLink uninstallAll.

		ocbTimesAllVarsWrite add:
			(self exampleCodeinstrumenter: [ :students :group |
				 students first haltOnWrite ]) timeToRunWithoutGC
			- instrumentationTime ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBMethodCall [

	30 timesRepeat: [
		| gr |
		MetaLink uninstallAll.
		gr := AMGroup new.
		instrumentationTime := [ gr haltOnCallTo: #textPrintStudent:on: ]
			                       timeToRunWithoutGC.
		MetaLink uninstallAll.

		ocbTimesMethodCall add:
			(self exampleCodeinstrumenter: [ :students :group |
				 group haltOnCallTo: #textPrintStudent:on: ]) timeToRunWithoutGC
			- instrumentationTime ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarRead [

	30 timesRepeat: [
		| student |
		MetaLink uninstallAll.
		student := AMStudent new.
		instrumentationTime := [ student haltOnReadTo: #marker ] timeToRunWithoutGC.
		MetaLink uninstallAll.
		ocbTimesOneVarRead add:
			(self exampleCodeinstrumenter: [ :students :group |
				 students first haltOnReadTo: #marker ]) timeToRunWithoutGC
			- instrumentationTime ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarReadWrite [

	30 timesRepeat: [
		| student |
		MetaLink uninstallAll.
		student := AMStudent new.
		instrumentationTime := [ student haltOnAccessTo: #marker ]
			                       timeToRunWithoutGC.
		MetaLink uninstallAll.

		ocbTimesOneVarReadWrite add:
			(self exampleCodeinstrumenter: [ :students :group |
				 students first haltOnAccessTo: #marker ]) timeToRunWithoutGC
			- instrumentationTime ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarWrite [

	30 timesRepeat: [
		| student |
		MetaLink uninstallAll.
		student := AMStudent new.
		instrumentationTime := [ student haltOnWriteTo: #marker ]
			                       timeToRunWithoutGC.
		MetaLink uninstallAll.

		ocbTimesOneVarWrite add:
			(self exampleCodeinstrumenter: [ :students :group |
				 students first haltOnWriteTo: #marker ]) timeToRunWithoutGC
			- instrumentationTime ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQAllVarsRead [

	self newSeekerDebugger.

	30 timesRepeat: [
		querySolver
			query: (TTQAllAccessesToInstanceVariablesOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid);
			resolve.
		ttqTimesAllVarsRead add: querySolver timeToRun ].

	30 timesRepeat: [
		self newSeekerDebugger.
		querySolver
			query: (TTQAllAccessesToInstanceVariablesOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid);
			resolve.
		ttqTimesAllVarsReadUncached add: querySolver timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQAllVarsWrite [

	self newSeekerDebugger.

	30 timesRepeat: [
		querySolver
			query: (TTQAllAssignmentsOfInstanceVariablesOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid);
			resolve.
		ttqTimesAllVarsWrite add: querySolver timeToRun ].

	30 timesRepeat: [
		self newSeekerDebugger.
		querySolver
			query: (TTQAllAssignmentsOfInstanceVariablesOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid);
			resolve.
		ttqTimesAllVarsWriteUncached add: querySolver timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQMethodCall [

	self newSeekerDebugger.
	oid := seekerDebugger tracer getOidOf: (seekerDebugger
			        evaluateExpression: 'group'
			        inContext:
			        seekerDebugger currentContext sender sender sender sender
				        home).

	30 timesRepeat: [
		querySolver
			query: (TTQAllMessagesSentToObjectWithSelector
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid
					 andMessageSelector: #textPrintOn:);
			resolve.
		ttqTimesMethodCall add: querySolver timeToRun ].

	30 timesRepeat: [
		self newSeekerDebugger.
		oid := seekerDebugger tracer getOidOf: (seekerDebugger
				        evaluateExpression: 'group'
				        inContext:
				        seekerDebugger currentContext sender sender sender sender
					        home).
		querySolver
			query: (TTQAllMessagesSentToObjectWithSelector
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid
					 andMessageSelector: #textPrintOn:);
			resolve.
		ttqTimesMethodCallUncached add: querySolver timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQOneVarRead [

	self newSeekerDebugger.

	30 timesRepeat: [
		querySolver
			query: (TTQAllAccessesToAnInstanceVariablesOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid
					 withVariableName: #marker);
			resolve.
		ttqTimesOneVarRead add: querySolver timeToRun ].

	30 timesRepeat: [
		self newSeekerDebugger.
		querySolver
			query: (TTQAllAccessesToAnInstanceVariablesOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid
					 withVariableName: #marker);
			resolve.
		ttqTimesOneVarReadUncached add: querySolver timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQOneVarWrite [

	self newSeekerDebugger.

	30 timesRepeat: [
		querySolver
			query: (TTQAllAssignmentsOfAnInstanceVariableOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid
					 withVariableName: #marker);
			resolve.
		ttqTimesOneVarWrite add: querySolver timeToRun ].

	30 timesRepeat: [
		self newSeekerDebugger.
		querySolver
			query: (TTQAllAssignmentsOfAnInstanceVariableOfObject
					 queryFrom: seekerDebugger programStates
					 withObjectOid: oid
					 withVariableName: #marker);
			resolve.
		ttqTimesOneVarWriteUncached add: querySolver timeToRun ]
]

{ #category : #'as yet unclassified' }
QueryVSOCBBenchmarker >> computeBenchmarkResult [

	result := OCBVSTTQBenchmarkResultSet new.

	self
		addBenchmarkResultNamed: 'oneVarRead'
		withPharoTimes: normalTimes
		withOcbTimes: ocbTimesOneVarRead
		withTTQCachedTimes: ttqTimesOneVarRead
		withTTQUncachedTimes: ttqTimesOneVarReadUncached;
		addBenchmarkResultNamed: 'oneVarWrite'
		withPharoTimes: normalTimes
		withOcbTimes: ocbTimesOneVarWrite
		withTTQCachedTimes: ttqTimesOneVarWrite
		withTTQUncachedTimes: ttqTimesOneVarWriteUncached;
		addBenchmarkResultNamed: 'allVarsRead'
		withPharoTimes: normalTimes
		withOcbTimes: ocbTimesAllVarsRead
		withTTQCachedTimes: ttqTimesAllVarsRead
		withTTQUncachedTimes: ttqTimesAllVarsReadUncached;
		addBenchmarkResultNamed: 'allVarsWrite'
		withPharoTimes: normalTimes
		withOcbTimes: ocbTimesAllVarsWrite
		withTTQCachedTimes: ttqTimesAllVarsWrite
		withTTQUncachedTimes: ttqTimesAllVarsWriteUncached;
		addBenchmarkResultNamed: 'methodCall'
		withPharoTimes: normalTimes
		withOcbTimes: ocbTimesMethodCall
		withTTQCachedTimes: ttqTimesMethodCall
		withTTQUncachedTimes: ttqTimesMethodCall
]

{ #category : #'as yet unclassified' }
QueryVSOCBBenchmarker >> exampleCodeinstrumenter: aBlock [

	^ [
	  | object |
	  object := AMParsingBugExample new.
	  object
		  createGroup;
		  createPromotion.

	  aBlock value: object students value: object group.
	  100 timesRepeat: [ object testStudentPrinting ] ]
]

{ #category : #initialization }
QueryVSOCBBenchmarker >> initialize [

	super initialize.
	seekerDebugger := SeekerDebugger headlessDebugBlock:
		                  (self exampleCodeinstrumenter: [ :students :group |
			                    ]).

	querySolver := QSCollection new.

	normalTimes := {  } asOrderedCollection.

	ttqTimesOneVarRead := {  } asOrderedCollection.
	ttqTimesOneVarWrite := {  } asOrderedCollection.
	ttqTimesAllVarsRead := {  } asOrderedCollection.
	ttqTimesAllVarsWrite := {  } asOrderedCollection.
	ttqTimesMethodCall := {  } asOrderedCollection.

	ocbTimesOneVarRead := {  } asOrderedCollection.
	ocbTimesOneVarWrite := {  } asOrderedCollection.
	ocbTimesOneVarReadWrite := {  } asOrderedCollection.
	ocbTimesAllVarsRead := {  } asOrderedCollection.
	ocbTimesAllVarsWrite := {  } asOrderedCollection.
	ocbTimesAllVarsReadWrite := {  } asOrderedCollection.
	ocbTimesMethodCall := {  } asOrderedCollection.

	ttqTimesOneVarReadUncached := {  } asOrderedCollection.
	ttqTimesOneVarWriteUncached := {  } asOrderedCollection.
	ttqTimesAllVarsReadUncached := {  } asOrderedCollection.
	ttqTimesAllVarsWriteUncached := {  } asOrderedCollection.
	ttqTimesMethodCallUncached := {  } asOrderedCollection
]

{ #category : #'instance creation' }
QueryVSOCBBenchmarker >> newSeekerDebugger [

	seekerDebugger := (SeekerDebugger headlessDebugBlock:
			                   (self exampleCodeinstrumenter: [ :students :group |
					                     ]))
		                  runReversibly;
		                  yourself.

	oid := seekerDebugger tracer getOidOf: (seekerDebugger
			        evaluateExpression: 'students first'
			        inContext:
			        seekerDebugger currentContext sender sender sender sender
				        home)
]

{ #category : #'instance creation' }
QueryVSOCBBenchmarker >> stepToGetFirstStudent [

	sindarinDebugger stepUntil: [
		sindarinDebugger assignmentVariableName = 'student' ].
	objectOfInterest := sindarinDebugger assignmentValue

]

{ #category : #'instance creation' }
QueryVSOCBBenchmarker >> stepToGetGroupOfStudents [

	sindarinDebugger stepUntil: [
		sindarinDebugger assignmentVariableName = 'group' ].
	objectOfInterest := sindarinDebugger assignmentValue
]
