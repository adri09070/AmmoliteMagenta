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
		'instrumentationTime',
		'object',
		'ttqTimesAllVarsReadWrite',
		'ttqTimesOneVarReadWrite'
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

{ #category : #benchmarking }
QueryVSOCBBenchmarker class >> benchmarkTTQAllVarsReadWrite [

	<script>
	self new benchmarkTTQAllVarsReadWrite
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker class >> benchmarkTTQOneVarRead [

	<script>
	self new benchmarkTTQOneVarRead
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker class >> benchmarkTTQOneVarReadWrite [

	<script>
	self new benchmarkTTQOneVarReadWrite
]

{ #category : #parsing }
QueryVSOCBBenchmarker class >> parseResults: aFileName [

	^ self new
		  parseResults: aFileName;
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

	self benchmarkTTQAllVarsReadWrite.

	self benchmarkTTQMethodCall.

	self computeBenchmarkResult
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkNormalTimes [
	self setupBase.
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsRead [

	self setupOCBAllVarsRead.
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsReadWrite [

	self setupOCBAllVarsReadWrite.
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsWrite [

	self setupOCBAllVarsWrite. 
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBMethodCall [

	self setupOCBMethodCall.
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarRead [

	self setupOCBOneVarRead.
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarReadWrite [

	self setupOCBOneVarReadWrite.
	self ocbench
]

{ #category : #'benchmarks-OCB' }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarWrite [

	self setupOCBOneVarWrite.
	self ocbench
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> benchmarkTTQAllVarsRead [

	self newSeekerDebugger.
	querySolver
		query: (TTQAllAccessesToInstanceVariablesOfObject
				 queryFrom: seekerDebugger programStates
				 withObjectOid: oid);
		resolve
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQAllVarsReadWrite [

	self newSeekerDebugger.
	querySolver
		query: (TTQAllReadingsAndWritingsToInstanceVariablesOfObject
				 queryFrom: seekerDebugger programStates
				 withObjectOid: oid);
		resolve
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> benchmarkTTQAllVarsWrite [

	self newSeekerDebugger.
	querySolver
		query: (TTQAllAssignmentsOfInstanceVariablesOfObject
				 queryFrom: seekerDebugger programStates
				 withObjectOid: oid);
		resolve
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> benchmarkTTQMethodCall [

	self newSeekerDebuggerWithGroupOID.

	querySolver
		query: (TTQAllMessagesSentToObjectWithSelector
				 queryFrom: seekerDebugger programStates
				 withObjectOid: oid
				 andMessageSelector: #textPrintOn:);
		resolve
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> benchmarkTTQOneVarRead [

	self newSeekerDebugger.
	(querySolver
		 query: (TTQAllAccessesToAnInstanceVariablesOfObject
				  queryFrom: seekerDebugger programStates
				  withObjectOid: oid
				  withVariableName: #marker);
		 resolve) inspect
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkTTQOneVarReadWrite [

	self newSeekerDebugger.
	querySolver query:
		(TTQAllReadingsAndWritingsToAnInstanceVariableOfObject
			 queryFrom: seekerDebugger programStates
			 withObjectOid: oid
			 withVariableName: #marker)
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> benchmarkTTQOneVarWrite [

	self newSeekerDebugger.
	querySolver
		query: (TTQAllAssignmentsOfAnInstanceVariableOfObject
				 queryFrom: seekerDebugger programStates
				 withObjectOid: oid
				 withVariableName: #marker);
		resolve
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
	  1000 timesRepeat: [ object testStudentPrinting ] ]
]

{ #category : #initialization }
QueryVSOCBBenchmarker >> initialize [

	super initialize.
	querySolver := QSCollection new.
]

{ #category : #'as yet unclassified' }
QueryVSOCBBenchmarker >> mapAllResultsToTimes: allResults [

	{
		('Pharo' -> normalTimes).
		('OC-AllVarReadWrite' -> ocbTimesAllVarsReadWrite).
		('OC-OneVarWrite' -> ocbTimesOneVarWrite).
		('OC-OneVarReadWrite' -> ocbTimesOneVarReadWrite).
		('OC-AllVarReads' -> ocbTimesAllVarsRead).
		('OC-OneVarRead' -> ocbTimesOneVarRead).
		('OC-MethodCall' -> ocbTimesMethodCall).
		('OC-AllVarWrites' -> ocbTimesAllVarsWrite) ". 'TTQ-OneVarWrite' -> ttqTimesOneVarWrite. 'TTQ-AllVarReads' -> ttqTimesAllVarsRead. 'TTQ-OneVarRead' -> ttqTimesOneVarRead . 'TTQ-MethodCall' -> ttqTimesMethodCall . 'TTQ-AllVarWrites' -> ttqTimesAllVarsWrite . TTQ-AllVarReadsWrites -> ttqTimesAllVarsReadWrite. TTQ-OneVarReadsWrites ->  ttqTimesOneVarReadWrite"  }
		asDictionary associationsDo: [ :assoc |
		self mapSuite: assoc key from: allResults to: assoc value ]
]

{ #category : #'as yet unclassified' }
QueryVSOCBBenchmarker >> mapSuite: aString from: allResults to: aCollectionOfTimes [

	(allResults select: [ :dict | "(dict at: 'suite')" "(dict at: 3) "
		 (dict at: 8) = aString ]) do: [ :dict |
		aCollectionOfTimes add: (dict at: 3) asNumber "(dict at: 1)" "(dict at: 'time')" ]
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> newSeekerDebugger [

	seekerDebugger := (SeekerDebugger headlessDebugBlock:
			                   self seekerExecutionBlock)
		                  runReversibly;
		                  yourself.

	oid := seekerDebugger tracer getOidOf: (seekerDebugger
			        evaluateExpression: 'object students first'
			        inContext: thisContext)
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> newSeekerDebuggerWithGroupOID [

	seekerDebugger := (SeekerDebugger headlessDebugBlock:
			                   self seekerExecutionBlock)
		                  runReversibly;
		                  yourself.

	oid := seekerDebugger tracer getOidOf: (seekerDebugger
			        evaluateExpression: 'object group'
			        inContext: thisContext)
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> ocbench [

	10 timesRepeat: [ object testStudentPrinting ]
]

{ #category : #parsing }
QueryVSOCBBenchmarker >> parseResults: aFileName [

	| csvFile readStream csvReader allResults |
	csvFile := aFileName asFileReference.
	csvFile isFile ifFalse: [ ^ self ].
	readStream := csvFile readStream.
	csvReader := NeoCSVReader on: readStream.

	csvReader
		separator: Character tab";
		addIgnoredFields: 2;
		""addFieldAt: 'time';""addFieldAt: 1;
		addIgnoredField;
		""addFieldAt: 'criterion';""addFieldAt: 2;
		addIgnoredFields: 2;
		""addFieldAt: 'suite';""addFieldAt: 3;
		addIgnoredFields: 5."

	.csvReader
		skipLine;
		skipLine;
		skipLine;
		skipLine.
	allResults := csvReader upToEnd.

	allResults := allResults select: [ :dict | " (dict at: 'criterion')"
		              "(dict at: 2)" (dict at: 5)  = 'total' ].
	self mapAllResultsToTimes: allResults.

	self computeBenchmarkResult
]

{ #category : #'benchmarks-TTOCB' }
QueryVSOCBBenchmarker >> seekerExecutionBlock [

	^ [
	  self setupBase.
	  self ocbench ]
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupBase [

	object := AMParsingBugExample new.
	object
		createGroup;
		createPromotion
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBAllVarsRead [
	self setupBase.
	object students first haltOnRead
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBAllVarsReadWrite [
	self setupBase.
	object students first haltOnAccess
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBAllVarsWrite [
	self setupBase.
	object students first haltOnWrite
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBMethodCall [
	self setupBase.
	object group haltOnCallTo: #textPrintStudent:on:
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBOneVarRead [
	self setupBase.
	object students first haltOnReadTo: #marker
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBOneVarReadWrite [
	self setupBase.
	object students first haltOnAccessTo: #marker
]

{ #category : #'setup-OCB' }
QueryVSOCBBenchmarker >> setupOCBOneVarWrite [
	self setupBase.
	object students first haltOnWriteTo: #marker
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
