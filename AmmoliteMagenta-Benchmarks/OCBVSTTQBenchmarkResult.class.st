Class {
	#name : #OCBVSTTQBenchmarkResult,
	#superclass : #Object,
	#instVars : [
		'label',
		'pharo',
		'ocb',
		'ttqCached',
		'ttqUncached',
		'ratios'
	],
	#category : #'AmmoliteMagenta-Benchmarks'
}

{ #category : #'as yet unclassified' }
OCBVSTTQBenchmarkResult class >> computeResultNamed: aString withPharo: pharoTimes withOcb: ocbTimes withTTQCached: ttqCachedTimes withTTQUncachedTimes: ttqUncachedTimes [

	^ self new
		  computeResultNamed: aString
		  withPharo: pharoTimes
		  withOcb: ocbTimes
		  withTTQCached: ttqCachedTimes
		  withTTQUncachedTimes: ttqUncachedTimes
]

{ #category : #'as yet unclassified' }
OCBVSTTQBenchmarkResult >> computeRatioBetween: aResultDictionary and: anotherResultDictionary [

	ratios
		at: ('{1}/{2}' format: {
					 (aResultDictionary at: 'label').
					 (anotherResultDictionary at: 'label') })
		put: (aResultDictionary at: 'average')
			/ (anotherResultDictionary at: 'average')
]

{ #category : #'as yet unclassified' }
OCBVSTTQBenchmarkResult >> computeRatios [

	self computeRatioBetween: ocb and: pharo.
	self computeRatioBetween: ttqCached and: ocb.
	self computeRatioBetween: ttqUncached and: ocb.
	self computeRatioBetween: ttqCached and: pharo.
	self computeRatioBetween: ttqUncached and: pharo
]

{ #category : #'as yet unclassified' }
OCBVSTTQBenchmarkResult >> computeResultIn: aDictionary withName: aString withTimes: aCollectionOfTimes [

	aDictionary
		at: 'label' put: aString;
		at: 'times' put: aCollectionOfTimes;
		at: 'average' put: aCollectionOfTimes average;
		at: 'confidenceInterval'
		put: 1.96 * aCollectionOfTimes stdev / aCollectionOfTimes size sqrt
]

{ #category : #'as yet unclassified' }
OCBVSTTQBenchmarkResult >> computeResultNamed: aString withPharo: pharoTimes withOcb: ocbTimes withTTQCached: ttqCachedTimes withTTQUncachedTimes: ttqUncachedTimes [

	label := aString.
	self computeResultIn: pharo withName: 'pharo' withTimes: pharoTimes.
	self computeResultIn: ocb withName: 'ocb' withTimes: ocbTimes.
	self
		computeResultIn: ttqCached
		withName: 'ttqCached'
		withTimes: ttqCachedTimes.
	self
		computeResultIn: ttqUncached
		withName: 'ttqUncached'
		withTimes: ttqUncachedTimes.
	self computeRatios
]

{ #category : #initialization }
OCBVSTTQBenchmarkResult >> initialize [

	pharo := Dictionary new.
	ocb := Dictionary new.
	ttqCached := Dictionary new.
	ttqUncached := Dictionary new.
	ratios := Dictionary new
]

{ #category : #accessing }
OCBVSTTQBenchmarkResult >> label [

	^ label
]

{ #category : #accessing }
OCBVSTTQBenchmarkResult >> ocb [

	^ ocb
]

{ #category : #accessing }
OCBVSTTQBenchmarkResult >> pharo [

	^ pharo
]

{ #category : #accessing }
OCBVSTTQBenchmarkResult >> ratios [

	^ ratios
]

{ #category : #accessing }
OCBVSTTQBenchmarkResult >> ttqCached [

	^ ttqCached
]

{ #category : #accessing }
OCBVSTTQBenchmarkResult >> ttqUncached [

	^ ttqUncached
]
