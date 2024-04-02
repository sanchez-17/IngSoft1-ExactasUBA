!classDefinition: #BooleanosTest category: 'Ejercicio 0.3'!
DenotativeObject subclass: #BooleanosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooleanosTest class' category: 'Ejercicio 0.3'!
BooleanosTest class
	instanceVariableNames: ''!

!BooleanosTest class methodsFor: 'negacion' stamp: 'GS 4/2/2024 14:35:02'!
testFalsoNegadoEsVerdadero
	Assert that: Falso no isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'negacion' stamp: 'Gas 3/18/2024 21:24:45'!
testVerdaderoNegadoEsFalso
	Assert that: Verdadero no isEqualTo: Falso
! !


!BooleanosTest class methodsFor: 'y' stamp: 'GS 4/2/2024 14:40:41'!
testFalsoYVerdaderoEsVerdadero
	Assert that: (Falso y: Verdadero) isEqualTo: Verdadero ! !

!BooleanosTest class methodsFor: 'y' stamp: 'GS 4/2/2024 14:36:25'!
testVerdaderoYFalsoEsFalso
	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !


!BooleanosTest class methodsFor: 'condicional' stamp: 'GS 4/2/2024 15:16:27'!
testFalsoSiVerdaderoIgnora
	Assert that: (Falso siVerdadero: [^'GG'] ) isEqualTo: Falso! !

!BooleanosTest class methodsFor: 'condicional' stamp: 'GS 4/2/2024 15:09:44'!
testSiFalsoRealizaAlgo
	Assert that: (Falso siFalso: [^'Chau'] ) isEqualTo: 'Chau' ! !

!BooleanosTest class methodsFor: 'condicional' stamp: 'GS 4/2/2024 15:17:11'!
testVerdaderoSiFalsoIgnora
	Assert that: (Verdadero siFalso: [^'GG'] ) isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'condicional' stamp: 'GS 4/2/2024 15:07:14'!
testVerdaderoSiVerdaderoRealizaAlgo
	"La accion a realizar es que diga hola"
	Assert that: (Verdadero siVerdadero:  [^'Hola'] ) isEqualTo: 'Hola'! !


!BooleanosTest class methodsFor: 'o' stamp: 'GS 4/2/2024 14:44:23'!
testFalsoOVerdaderoEsVerdadero
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'o' stamp: 'GS 4/2/2024 14:42:44'!
testVerdaderoOFalsoEsVerdadero
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero! !


!classDefinition: #Falso category: 'Ejercicio 0.3'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: 'Ejercicio 0.3'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 14:34:46'!
no
	^Verdadero! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 14:44:49'!
o: unBooleano
	^unBooleano! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 15:10:53'!
siFalso: unaAccionARealizarUIgnorar 
	^unaAccionARealizarUIgnorar value.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 15:15:05'!
siVerdadero: unaAccionARealizarUIgnorar 
 ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 14:39:36'!
y: unBooleano
	^unBooleano 
	! !


!classDefinition: #Verdadero category: 'Ejercicio 0.3'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: 'Ejercicio 0.3'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Gas 3/18/2024 21:38:00'!
no
	^Falso! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 14:43:35'!
o: unBooleano
	^Verdadero.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 15:17:28'!
siFalso: unaAccionARealizarUIgnorar 
	! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 15:07:44'!
siVerdadero: unaAccionARealizarUIgnorar 
	^unaAccionARealizarUIgnorar value.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 14:37:35'!
y: unBooleano
	^unBooleano 
	! !
