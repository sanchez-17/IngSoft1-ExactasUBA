!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook paulMcCartney johnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:03'!
assertNumberOfActivemembersIn:aCustomerBook is: aNumberOfActiveExpected andSuspendedIs: aNumberOfSuspendedExpected
	self assert: aNumberOfActiveExpected equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedExpected equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveExpected + aNumberOfSuspendedExpected equals: aCustomerBook numberOfCustomers
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 17:40:51'!
should: aBlockThatShouldFail raise: aTypeOfError assert: aVerificationBlock
	[ aBlockThatShouldFail value.
	self fail ]
		on: aTypeOfError 
		do: aVerificationBlock
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 17:58:15'!
should: aBlockToMeasure takesLessThan:timeLimit
	self assert: (self timeOfRunning: aBlockToMeasure) < timeLimit! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:18'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self 
		should: [customerBook addCustomerNamed: johnLennon .] 
		takesLessThan: 50 * millisecond
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:14'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self 
		should: [customerBook removeCustomerNamed: paulMcCartney.] 
		takesLessThan: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:11'!
test03CanNotAddACustomerWithEmptyName 

	self 
		should:  [customerBook addCustomerNamed: ''.]
		raise:  Error
		assert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:18'!
test04CanNotRemoveAnInvalidCustomer
	
	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [customerBook removeCustomerNamed: 'Paul McCartney'.] 
		raise: NotFound 
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:14'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertNumberOfActivemembersIn: customerBook is: 0 andSuspendedIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:14'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self assertNumberOfActivemembersIn: customerBook is: 0 andSuspendedIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:18'!
test07CanNotSuspendAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon.

	self 
		should:  [customerBook suspendCustomerNamed: 'George Harrison'.]
		raise:  CantSuspend
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 18:10:18'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self 
		should:  [customerBook suspendCustomerNamed: johnLennon.]
		raise:  CantSuspend
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GS 4/26/2024 17:26:39'!
timeOfRunning: aBlockToMeasure
	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^ millisecondsAfterRunning-millisecondsBeforeRunning! !


!CustomerBookTest methodsFor: 'setUp' stamp: 'GS 4/26/2024 18:10:18'!
setUp
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	paulMcCartney := 'Paul McCartney'.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
