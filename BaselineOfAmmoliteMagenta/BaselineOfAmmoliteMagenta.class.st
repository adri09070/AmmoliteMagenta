Class {
	#name : #BaselineOfAmmoliteMagenta,
	#superclass : #BaselineOf,
	#category : #BaselineOfAmmoliteMagenta
}

{ #category : #baselines }
BaselineOfAmmoliteMagenta >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'AmmoliteMagenta'.
		spec package: 'AmmoliteMagenta-Tests' ].
	spec for: #benchmarks do: [
		spec baseline: 'Seeker' with: [
			spec repository:
				'github://ValentinBourcier/SeekerDebugger/new-object-centric-ttqs' ].

		spec package: 'AmmoliteMagenta'.
		spec
			package: 'AmmoliteMagenta-Tests'
			with: [ spec requires: #( 'AmmoliteMagenta' ) ].
		spec
			package: 'AmmoliteMagenta-Benchmarks'
			with: [ spec requires: #( 'AmmoliteMagenta-Tests'
			   'Seeker' ) ] ]
]
