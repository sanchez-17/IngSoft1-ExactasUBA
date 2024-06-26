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

!ImportTest methodsFor: 'test' stamp: 'GS 6/26/2024 18:31:49'!
test01Import
	CustomerImporter valueOn: session from: self validData.
	
	self assertImportedRightNumberOfCustomers: 2.
	self assertImportedRightNumberOfAddresses: 3.
	
	self assertPepeSanchezWasImportedCorrectly.
	self assertJuanPerezWasImportedCorrectly.
	! !


!ImportTest methodsFor: 'testing' stamp: 'GS 6/26/2024 18:23:57'!
assertAddressOf: importedCustomer withStreetName: aStreetName hasNumber: aNumber zipCode: aZipCode town: aTown province: aProvince

	^ self assert: ((importedCustomer addressAt: aStreetName) haveThisStreetNumber:  aNumber 
	town: aTown 
	zipCode: aZipCode 
	andProvince: aProvince)! !

!ImportTest methodsFor: 'testing' stamp: 'GS 6/26/2024 17:32:36'!
assertImportedRightNumberOfAddresses: aNumberOfAddresses

	^ self assert: (session selectAllOfType: Address) size = aNumberOfAddresses! !

!ImportTest methodsFor: 'testing' stamp: 'GS 6/26/2024 17:29:21'!
assertImportedRightNumberOfCustomers: aNumberOfCustomer

	^ self assert: (session selectAllOfType: Customer) size = aNumberOfCustomer! !

!ImportTest methodsFor: 'testing' stamp: 'GS 6/26/2024 18:24:15'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |
	importedCustomer := self selectACustomerOfType: 'C'.
	self assertValidCustomerImport: (importedCustomer)
		withFirstName: 'Juan' 
		lastName: 'Perez'	 
		identificationType: 'C'	 
		andIdentificationNumber: '23-25666777-9'	.

	self assertAddressOf: importedCustomer withStreetName: 'Alem' hasNumber: 1122 zipCode: 1001 town: 'CABA' province: 'CABA'.! !

!ImportTest methodsFor: 'testing' stamp: 'GS 6/26/2024 18:27:45'!
assertPepeSanchezWasImportedCorrectly

	| importedCustomer |
	importedCustomer := self selectACustomerOfType: 'D'.
	self assertValidCustomerImport: (importedCustomer )
		withFirstName: 'Pepe' 
		lastName: 'Sanchez' 
		identificationType: 'D' 
		andIdentificationNumber: '22333444'	.
	
	self assertAddressOf: importedCustomer withStreetName: 'San Martin'  
		hasNumber: 3322 
		zipCode: 1636 
		town:  'Olivos'  
		province: 'BsAs'.
	self assertAddressOf: importedCustomer 
		withStreetName: 'Maipu'  
		hasNumber: 888 
		zipCode: 1122 
		town:  'Florida'   
		province: 'Buenos Aires'.
	! !

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


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'GS 6/26/2024 15:25:25'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction
	! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'GS 6/23/2024 17:45:39'!
tearDown
	session commit.
	session close! !


!ImportTest methodsFor: 'testing data' stamp: 'GS 6/26/2024 15:56:35'!
validData
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'as yet unclassified' stamp: 'GS 6/26/2024 18:07:54'!
selectFromCustomer: aRenameMe1 theAddressWithStreetName: aRenameMe2 
	^aRenameMe1 addresses detect: [:anAddress|
	anAddress isAt: aRenameMe2] ifNone: [self fail]! !


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


!Address methodsFor: 'testing' stamp: 'GS 6/26/2024 17:51:39'!
isAt: aStreetName 
	^streetName = aStreetName! !


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


!Customer methodsFor: 'as yet unclassified' stamp: 'GS 6/26/2024 18:10:31'!
addressAt: anStreetName 
	^addresses detect: [:anAddress| anAddress isAt: anStreetName] ifNone: [self fail]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #CustomerImporter!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'importing' stamp: 'GS 6/26/2024 15:46:16'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: aStream open: 'input.txt' forWrite: false.
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


!classDefinition: #CustomerImporter category: #CustomerImporter!
Object subclass: #CustomerImporter
	instanceVariableNames: 'inputStream session line newCustomer newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/26/2024 18:41:52'!
hasLineToImport

	line := inputStream nextLine. 
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/26/2024 18:29:49'!
initializeOn: aSession from: aStream 
	
	inputStream := aStream.
	session := aSession.
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/26/2024 18:44:29'!
isACostumer

	^ line beginsWith: 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/26/2024 18:44:52'!
isAnAddress

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/26/2024 18:44:57'!
processAndImportData: data

	self isACostumer ifTrue: [ self saveCustomer: data ].

	self isAnAddress ifTrue: [ self saveAddress: data ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/23/2024 19:07:36'!
saveAddress: data
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: data second.
	newAddress streetNumber: data third asNumber .
	newAddress town: data fourth.
	newAddress zipCode: data fifth asNumber .
	newAddress province: data sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/23/2024 19:13:38'!
saveCustomer: data
	
	newCustomer := Customer new.
	newCustomer firstName: data second.
	newCustomer lastName: data third.
	newCustomer identificationType: data fourth.
	newCustomer identificationNumber: data fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GS 6/26/2024 18:42:00'!
value
	
	
	[self hasLineToImport ] whileTrue: [| data |
		data := line findTokens: $,.
		self processAndImportData: data. ].

	inputStream close.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: #CustomerImporter!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'initialization' stamp: 'GS 6/26/2024 18:30:47'!
on: aSession from: aStream  

	^self new initializeOn: aSession from: aStream! !

!CustomerImporter class methodsFor: 'initialization' stamp: 'GS 6/26/2024 18:31:23'!
valueOn: aSession from: aStream  

	^(self on: aSession from: aStream) value! !


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


!DataBaseSession methodsFor: 'as yet unclassified' stamp: 'GS 6/26/2024 15:22:55'!
createDataBaseSession

	^ DataBaseSession for: (Array with: Address with: Customer)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: #CustomerImporter!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
