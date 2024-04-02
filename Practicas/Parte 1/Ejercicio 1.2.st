!classDefinition: #Bill category: #'Ejercicio 0.2'!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: #'Ejercicio 0.2'!
Bill class
	instanceVariableNames: 'energia'!

!Bill class methodsFor: 'as yet unclassified' stamp: 'GS 3/14/2024 18:56:31'!
caminar: unaCantidadDeKilometros
	energia := energia - 3 - unaCantidadDeKilometros.
	^ energia! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'GS 3/14/2024 18:50:37'!
comer: unaCantidadDeKilosDeCerebro
	energia := energia + (4 * unaCantidadDeKilosDeCerebro).
	^energia! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'GS 3/14/2024 18:47:22'!
energia
	^ energia! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 'GS 4/2/2024 00:42:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 942.! !

Bill initializeAfterFileIn!