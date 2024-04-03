!classDefinition: #I category: 'Ejercicio 0.4'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Ejercicio 0.4'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 01:01:51'!
* aMultiplicand
	^aMultiplicand! !

!I class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 00:46:48'!
+ anAdder
	^anAdder next! !

!I class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 00:49:43'!
- sustrahend
	self error: 'No se puede restar al numero I'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 01:22:31'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 23:22:34'!
previous
	self error: 'I no tiene previo' ! !


!classDefinition: #II category: 'Ejercicio 0.4'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Ejercicio 0.4'!
II class
	instanceVariableNames: 'previo'!

!II class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 01:21:59'!
* aMultiplicand
	| factor1 resultado|
	resultado := self.
	factor1 := aMultiplicand previous.
	[factor1 = I] whileFalse: [
		resultado := resultado + self.
		factor1 := factor1 previous.].
	^resultado.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 00:53:07'!
+ anAdder
	^self previous + anAdder next. ! !

!II class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 01:08:27'!
- sustrahend
	^self previous.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'GS 4/2/2024 23:26:31'!
next
	"Crea el siguiente numero, y setea su numero previo el numero actual"
	|next|
	next := self createChildNamed: self name,'x'.
	next previo: self name.
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 01:21:55'!
previous
	^I! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'GS 4/3/2024 01:23:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := nil.! !


!classDefinition: #III category: 'Ejercicio 0.4'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 0.4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Ejercicio 0.4'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 01:21:58'!
- sustrahend
	sustrahend = I 
		ifTrue: [^self previous]
		ifFalse: [^self previous - sustrahend previous].! !

!III class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 00:38:05'!
next
	"Crea el siguiente numero, y setea su numero previo el numero actual"
	|next|
	next := self cloneNamed: self name,'x'.
	next previo: self name.
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 00:34:43'!
previo: numeroPrevio
	previo := numeroPrevio! !

!III class methodsFor: 'as yet unclassified' stamp: 'GS 4/3/2024 00:42:09'!
previous
	^previo! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'GS 4/3/2024 01:23:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := #xx.! !

II initializeAfterFileIn!
III initializeAfterFileIn!