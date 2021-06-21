"
I read local resources from a directory ""repository"".
These resources must be text files with an item per line,
each line separated by a carriage return.
"
Class {
	#name : #AMLocalRepository,
	#superclass : #Object,
	#category : #'AmmoliteMagenta-model'
}

{ #category : #api }
AMLocalRepository class >> readAllPromotions [

	| repository |
	repository := self new.
	^ repository allFileReferences collect: [ :f | 
		  f path basenameWithoutExtension
		  -> (repository readFileReference: f) ]
]

{ #category : #reading }
AMLocalRepository >> allFileReferences [

	^ self localDirectory children
]

{ #category : #origins }
AMLocalRepository >> localDirectory [ 
	|dir|
	dir := FileSystem workingDirectory / 'repository'.
	dir ensureCreateDirectory.
	^dir
]

{ #category : #reading }
AMLocalRepository >> readFileReference: aFileReference [

	^ aFileReference binaryReadStream contents asString splitOn:
		  OSPlatform current lineEnding
]
