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

{ #category : #abstract }
AMLocalRepository >> allFileReference: aFileReference [

	^ self localDirectory contents
]

{ #category : #origins }
AMLocalRepository >> localDirectory [ 
	|dir|
	dir := FileSystem workingDirectory / 'repository'.
	dir ensureCreateDirectory.
	^dir
]

{ #category : #abstract }
AMLocalRepository >> readFileReference: aFileReference [

	^ aFileReference contents splitOn: OSPlatform current lineEnding
]
