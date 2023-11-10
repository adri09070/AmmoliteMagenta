Class {
	#name : #BaselineOfAmmoliteMagenta,
	#superclass : #BaselineOf,
	#category : #BaselineOfAmmoliteMagenta
}

{ #category : #baselines }
BaselineOfAmmoliteMagenta >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'Seeker' with: [
			spec repository:
				'github://ValentinBourcier/SeekerDebugger:new-object-centric-ttqs' ].
			
		spec baseline: 'NeoCSV' with: [spec repository: 'github://svenvc/NeoCSV/repository'].

		spec package: 'AmmoliteMagenta'.
		spec
			package: 'AmmoliteMagenta-Tests'
			with: [ spec requires: #( 'AmmoliteMagenta' ) ].
		spec
			package: 'AmmoliteMagenta-Benchmarks'
			with: [ spec requires: #( 'AmmoliteMagenta-Tests'
			   'Seeker' 'NeoCSV' ) ] ]
]
