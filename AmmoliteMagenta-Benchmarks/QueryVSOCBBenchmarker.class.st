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
		'objectOfInterest'
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
QueryVSOCBBenchmarker >> benchmark [

	1 halt.
	self benchmarkNormalTimes.

	1 halt.
	self benchmarkOCBOneVarRead.
	1 halt.
	self benchmarkOCBOneVarWrite.
	1 halt.
	self benchmarkOCBOneVarReadWrite.
	1 halt.
	self benchmarkOCBAllVarsRead.
	1 halt.
	self benchmarkOCBAllVarsWrite.
	1 halt.
	self benchmarkOCBAllVarsReadWrite.
	1 halt.
	self benchmarkOCBMethodCall.
	1 halt.

	1 halt.
	self benchmarkTTQOneVarRead.
	1 halt.
	self benchmarkTTQOneVarWrite.
	1 halt.
	self benchmarkTTQAllVarsRead.
	1 halt.
	self benchmarkTTQAllVarsWrite.
	1 halt.
	self benchmarkTTQMethodCall
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkNormalTimes [

	30 timesRepeat: [
		normalTimes add: [
			self exampleCode
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsRead [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetFirstStudent.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnRead.

		ocbTimesAllVarsRead add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsReadWrite [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetFirstStudent.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnAccess.

		ocbTimesAllVarsReadWrite add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBAllVarsWrite [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetFirstStudent.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnWrite.

		ocbTimesAllVarsWrite add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBMethodCall [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetGroupOfStudents.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnCallTo: #textPrintOn:.

		ocbTimesMethodCall add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarRead [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetFirstStudent.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnReadTo: #marker.

		ocbTimesOneVarRead add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarReadWrite [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetFirstStudent.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnAccessTo: #marker.

		ocbTimesOneVarReadWrite add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
]

{ #category : #benchmarking }
QueryVSOCBBenchmarker >> benchmarkOCBOneVarWrite [

	| process |
	30 timesRepeat: [
		self newSindarinDebugger.
		self stepToGetFirstStudent.
		process := sindarinDebugger debugSession process.
		objectOfInterest haltOnWriteTo: #marker.

		ocbTimesOneVarWrite add: [
			process resume
				on: TestFailure
				do: [  ] ] timeToRun ]
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
QueryVSOCBBenchmarker >> exampleCode [

	^ [ AMParsingBugExample new testStudentPrinting ]
]

{ #category : #initialization }
QueryVSOCBBenchmarker >> initialize [

	super initialize.
	seekerDebugger := SeekerDebugger headlessDebugBlock: self exampleCode.

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
			                   self exampleCode)
		                  runReversibly;
		                  yourself.

	oid := seekerDebugger tracer getOidOf: (seekerDebugger
			        evaluateExpression: 'students first'
			        inContext:
			        seekerDebugger currentContext sender sender sender sender
				        home)
]

{ #category : #'instance creation' }
QueryVSOCBBenchmarker >> newSindarinDebugger [

	sindarinDebugger := SindarinDebugger debug: self exampleCode
]

{ #category : #'instance creation' }
QueryVSOCBBenchmarker >> stepToGetFirstStudent [

	sindarinDebugger stepUntil: [
		sindarinDebugger assignmentVariableName = 'students' ].
	objectOfInterest := sindarinDebugger assignmentValue first

]

{ #category : #'instance creation' }
QueryVSOCBBenchmarker >> stepToGetGroupOfStudents [

	sindarinDebugger stepUntil: [
		sindarinDebugger assignmentVariableName = 'group' ].
	objectOfInterest := sindarinDebugger assignmentValue
]
