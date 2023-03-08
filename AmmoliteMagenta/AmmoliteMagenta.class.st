Class {
	#name : #AmmoliteMagenta,
	#superclass : #Object,
	#category : #'AmmoliteMagenta-model'
}

{ #category : #running }
AmmoliteMagenta class >> run [
	AMGroupBuilderPresenter openOn: {
		(STON fromString: 
			(STON fromString: AmmoliteMagentaTaskConfiguration new taskData) asString
		)
	}
]
