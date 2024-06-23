!classDefinition: #PersistentSet category: #CustomerImporter!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !


!PersistentSet methodsFor: 'private' stamp: 'HAW 6/18/2024 10:24:25'!
species

	^Set ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: #CustomerImporter!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: #CustomerImporter!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'test' stamp: 'GS 6/23/2024 18:01:23'!
selectACustomerOfType: aType

	^ (session select: [:aCustomer| aCustomer identificationType = aType] ofType: Customer) anyOne! !

!ImportTest methodsFor: 'test' stamp: 'GS 6/23/2024 18:07:05'!
selectFromCustomer: aCustomer1 theAddressWithStreetName: aStreetName

	^ (aCustomer1 addresses select: [:anAddress| anAddress streetName = aStreetName]) anyOne! !

!ImportTest methodsFor: 'test' stamp: 'GS 6/23/2024 17:45:02'!
setUp

	self importCustomers.! !

!ImportTest methodsFor: 'test' stamp: 'GS 6/23/2024 18:23:23'!
test01Import
	| aCustomer1 aCustomer2 address1 address2 address3 |
	self assert: (session selectAllOfType: Customer) size = 2.
	self assert: (session selectAllOfType: Address) size = 3.
	aCustomer1 := self selectACustomerOfType: 'D'.
	self assertValidCustomerImport: aCustomer1 
		withFirstName: 'Pepe' 
		lastName: 'Sanchez' 
		identificationType: 'D' 
		andIdentificationNumber: '22333444'	.
	
	aCustomer2 := self selectACustomerOfType: 'C'.
	self assertValidCustomerImport: aCustomer2 
		withFirstName: 'Juan' 
		lastName: 'Perez'	 
		identificationType: 'C'	 
		andIdentificationNumber: '23-25666777-9'	.
	
	address1 := self selectFromCustomer: aCustomer1 theAddressWithStreetName: 'San Martin'.
	self assertValidAddressImport: address1 
		withStreetNumber: 3322 
		town: 'Olivos' 
		zipCode: 1636 
		andProvince: 'BsAs'.
	
	address2 := self selectFromCustomer: aCustomer1 theAddressWithStreetName: 'Maipu'.
	self assertValidAddressImport: address2 
		withStreetNumber: 888 
		town: 'Florida' 
		zipCode: 1122 
		andProvince: 'Buenos Aires'.
		
	address3 := self selectFromCustomer: aCustomer2 theAddressWithStreetName: 'Alem'.
	
	self assertValidAddressImport: address3 
		withStreetNumber: 1122 
		town: 'CABA' 
		zipCode: 1001 
		andProvince: 'CABA'.
	! !


!ImportTest methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 18:04:36'!
importCustomers

	"
	self importCustomers
	
	dataBaseSession := self importCustomers.
	"
	| inputStream  newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	

	inputStream close.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 17:45:39'!
tearDown
	session commit.
	session close! !


!ImportTest methodsFor: 'testing' stamp: 'GS 6/23/2024 18:14:03'!
assertValidAddressImport: anAddress withStreetNumber: aStreetNumber town: aTown zipCode: aZipCode andProvince: aProvince
	
	self assert: (anAddress haveThisStreetNumber: aStreetNumber town: aTown zipCode: aZipCode andProvince: aProvince).
	! !

!ImportTest methodsFor: 'testing' stamp: 'GS 6/23/2024 18:10:31'!
assertValidCustomerImport: aCustomer withFirstName: firstName lastName: lastName identificationType: identificationType andIdentificationNumber: identificationNumber    
	
	self assert: (aCustomer haveThisFirstName: firstName
						  lastName: lastName
						  identificationType: identificationType
						  identificationNumber: identificationNumber).
	! !


!classDefinition: #Address category: #CustomerImporter!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 18:20:11'!
haveThisProvince: aProvince

	^ province = aProvince! !

!Address methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 18:16:26'!
haveThisStreetNumber: aStreetNumber

	^ streetNumber = aStreetNumber! !

!Address methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 18:20:11'!
haveThisStreetNumber: aStreetNumber town: aTown zipCode: aZipCode andProvince: aProvince 
	
	 ^((self haveThisStreetNumber: aStreetNumber)) and:[self haveThisTown: aTown.] and:[self haveThisZipCode: aZipCode] and: [self haveThisProvince: aProvince].! !

!Address methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 18:19:28'!
haveThisTown: aTown

	^ town = aTown! !

!Address methodsFor: 'as yet unclassified' stamp: 'GS 6/23/2024 18:19:59'!
haveThisZipCode: aZipCode

	^ zipCode = aZipCode! !


!classDefinition: #Customer category: #CustomerImporter!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:42'!
initialize

	super initialize.
	addresses := Set new.! !


!Customer methodsFor: 'testing' stamp: 'GS 6/23/2024 17:55:36'!
haveThisFirstName: aFirstName

	^ firstName = aFirstName! !

!Customer methodsFor: 'testing' stamp: 'GS 6/23/2024 17:57:17'!
haveThisFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber 
	^(self haveThisFirstName: aFirstName) 
		and:[self haveThisLastName: aLastName] 
		and:[self haveThisIdentificationType: anIdentificationType]  
		and: [self haveThisIdentificationNumber: anIdentificationNumber]! !

!Customer methodsFor: 'testing' stamp: 'GS 6/23/2024 17:57:17'!
haveThisIdentificationNumber: anIdentificationNumber

	^ identificationNumber = anIdentificationNumber! !

!Customer methodsFor: 'testing' stamp: 'GS 6/23/2024 17:56:32'!
haveThisIdentificationType: anIdentificationType

	^ identificationType = anIdentificationType! !

!Customer methodsFor: 'testing' stamp: 'GS 6/23/2024 17:56:02'!
haveThisLastName: aLastName

	^ lastName = aLastName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #CustomerImporter!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'importing' stamp: 'HAW 6/18/2024 10:25:27'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!classDefinition: #DataBaseSession category: #CustomerImporter!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: #CustomerImporter!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
