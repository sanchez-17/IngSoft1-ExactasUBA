!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'GS 4/26/2024 20:01:03'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'GS 4/26/2024 20:01:09'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'GS 4/26/2024 20:01:21'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'GS 4/26/2024 20:01:24'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'GS 4/26/2024 20:11:16'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:29:26'!
* aMultiplier 
	^self subclassResponsibility 
	"
	(type = #Entero and: [aMultiplier type = #Entero]) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	(type = #Fraccion and: [aMultiplier type = #Fraccion]) ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ].
		
	self error: 'Tipo de número no soportado'
	"! !

!Numero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 20:11:48'!
+ anAdder 
	self subclassResponsibility 
	
	"(type = #Entero and: [anAdder type = #Entero]) ifTrue:
		[ ^self class with: value + anAdder integerValue ].
	
	(type = #Fraccion and: [anAdder type = #Fraccion]) ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ].
	
	self error: 'Tipo de número no soportado'"
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:38:18'!
negated
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:52:30'!
printOn: aStream
	self subclassResponsibility! !


!Numero methodsFor: 'testing' stamp: 'GS 4/26/2024 19:35:00'!
isNegative
	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'GS 4/26/2024 20:11:35'!
isOne
	^self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'GS 4/26/2024 19:50:45'!
isZero
	self subclassResponsibility ! !




!Numero methodsFor: 'comparing' stamp: 'GS 4/26/2024 19:56:10'!
= anObject

	self subclassResponsibility ! !

!Numero methodsFor: 'comparing' stamp: 'GS 4/26/2024 19:37:11'!
hash
	^self subclassResponsibility ! !


!Numero methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 20:03:32'!
initializeWith: aValue
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !




!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'comparing' stamp: 'GS 4/26/2024 19:56:02'!
=anObject
	^(anObject isKindOf: self class) and: [value = anObject integerValue].
		! !

!Entero methodsFor: 'comparing' stamp: 'GS 4/26/2024 19:36:11'!
hash
	^value hash! !


!Entero methodsFor: 'value' stamp: 'GS 4/26/2024 19:31:22'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'GS 4/26/2024 19:33:47'!
isNegative
	^value < 0 ! !

!Entero methodsFor: 'testing' stamp: 'GS 4/26/2024 19:41:36'!
isOne
	^value = 1 ! !

!Entero methodsFor: 'testing' stamp: 'GS 4/26/2024 19:42:37'!
isZero
	^value = 0! !


!Entero methodsFor: 'printing' stamp: 'GS 4/26/2024 19:51:58'!
printOn: aStream
	aStream print: value ! !


!Entero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:29:12'!
* aMultiplier
	^self class with: value * aMultiplier integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:11:04'!
+ anIntegerAdder
	^self class with: value + anIntegerAdder integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:30:44'!
// aDivisor 
	^self class with: value // aDivisor integerValue
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:32:20'!
greatestCommonDivisorWith: anEntero 
	^self class with: (value gcd: anEntero integerValue)
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:38:00'!
negated
	^self * (self class with: -1) ! !


!Entero methodsFor: 'initialization' stamp: 'GS 4/26/2024 19:38:36'!
initializeWith: aValue
	
	value := aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 20:07:46'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:31:08'!
denominator

	^denominator! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:38:45'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:33:36'!
isNegative
	^denominator < 0! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:41:36'!
isOne
	^false! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:42:37'!
isZero
	^false! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 20:02:50'!
negated
	^self class with: numerator * (Entero with: -1) over: denominator ! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:31:50'!
numerator

	^numerator! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 19:52:06'!
printOn: aStream
	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator! !


!Fraccion methodsFor: 'comparing' stamp: 'GS 4/26/2024 19:56:02'!
= anObject
	^(anObject isKindOf: self class) and: [ 
			(numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'GS 4/26/2024 19:36:30'!
hash
	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:29:07'!
* aMultiplier
	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GS 4/26/2024 19:11:14'!
+ anFractionalAdder
	| newNumerator newDenominator |
		
	newNumerator := (numerator * anFractionalAdder denominator) + (denominator * anFractionalAdder numerator).
	newDenominator := denominator * anFractionalAdder denominator.
		
	^ self class with: newNumerator over: newDenominator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'as yet unclassified' stamp: 'GS 4/26/2024 20:07:56'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
