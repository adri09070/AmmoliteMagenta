Class {
	#name : #OCBVSTTQBenchmarkResultSet,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : #'AmmoliteMagenta-Benchmarks'
}

{ #category : #adding }
OCBVSTTQBenchmarkResultSet >> addResult: aBenchmarkResult named: aString [

	results at: aString put: aBenchmarkResult
]

{ #category : #initialization }
OCBVSTTQBenchmarkResultSet >> initialize [

	results := Dictionary new
]
