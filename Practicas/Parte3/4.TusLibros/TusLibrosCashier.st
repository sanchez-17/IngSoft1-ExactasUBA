!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'GS 6/4/2024 21:18:29'!
createCart
	
	^Cart acceptingItemsOf: CashierTest new defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/3/2024 21:23:10'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:26:40'!
defaultCatalog
	|aCatalog|
	aCatalog := Dictionary new. 
	aCatalog at: self itemSellByTheStore put: self defaultItemPrice.
	aCatalog at: self itemSellByTheStore2 put: self defaultItemPrice2.
	^aCatalog ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:06:59'!
defaultItemPrice

	^ 10000! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:27:03'!
defaultItemPrice2
	^20000! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/3/2024 21:20:10'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:26:11'!
itemSellByTheStore2
	^'Other Valid Book'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/3/2024 21:51:45'!
test01CantCheckOutAnEmptyCart
	| aCart aCashier aCreditCard |
	aCart := self createCart .
	aCashier := Cashier new. 
	aCreditCard := self validCreditCard.
	[aCashier checkout: aCart withCreditCard: aCreditCard]
	on: Error - MessageNotUnderstood 
	do:[:anError | self assert: anError messageText equals: aCashier class cantCheckoutEmptyCartErrorMessage.]
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:20:29'!
test02AssertThatTicketIsThePriceOfItemSelled
	| aCart aCashier aCreditCard aTicket |
	
	aCart := self createCart .
	
	aCart add: self itemSellByTheStore.
	
	aCashier := Cashier new. 
	
	aCreditCard := self validCreditCard.
	
	aTicket := aCashier checkout: aCart withCreditCard: aCreditCard.
	
	self assert: aTicket equals: self defaultItemPrice. 

! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:27:47'!
test03AssertThatTicketIsThePriceOfItemsSelled
	| aCart aCashier aCreditCard aTicket |
	
	aCart := self createCart .
	
	aCart add: self itemSellByTheStore .
	aCart add: self itemSellByTheStore2.
	
	aCashier := Cashier new. 
	
	aCreditCard := self validCreditCard.
	
	aTicket := aCashier checkout: aCart withCreditCard: aCreditCard.
	
	self assert: aTicket equals: (self defaultItemPrice +  self defaultItemPrice2). 

! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 23:23:53'!
test04CantCheckOutWithExpiredCreditCard
	| aCart aCashier aCreditCard aNumberCard expiredDate |
	
	aCart := self createCart .
	
	aNumberCard := '1234123412341234'.
	expiredDate := Month month: (Date today monthIndex - 1) year: Date today yearNumber .
	
	aCart add: self itemSellByTheStore .
	aCart add: self itemSellByTheStore2.
	
	aCashier := Cashier new. 
	
	aCreditCard := CreditCard withNumber: aNumberCard andExpiredDate: expiredDate.
	
	[aCashier checkout: aCart withCreditCard: aCreditCard.
	self fail.]
	on: Error - MessageNotUnderstood
	do:[:anError | 
		self 
			assert: anError messageText 
			equals: aCashier class cantCheckoutWithExpiredCreditCardErrorMessage] 
	
	

! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 23:21:36'!
validCreditCard

	^ CreditCard withNumber: '1234123412341234' andExpiredDate: Date tomorrow.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'GS 6/4/2024 21:09:42'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:24:30'!
priceOf: anItem
	^catalog at: anItem.
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 21:16:42'!
totalAmount
	
	^items inject: 0 into: [:sum :anItem | sum + (catalog at: anItem)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 23:10:09'!
checkout: aCart withCreditCard: aCreditCard 
	
	aCart isEmpty ifTrue: [self error: self class cantCheckoutEmptyCartErrorMessage].
	aCreditCard isExpired ifTrue: [self error: self class cantCheckoutWithExpiredCreditCardErrorMessage].
	^aCart totalAmount 
	
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 22:59:32'!
isExpired: aCreditCard 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'GS 6/3/2024 21:37:58'!
cantCheckoutEmptyCartErrorMessage
	^'you cant check out an empty cart!!!!'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 23:19:34'!
cantCheckoutWithExpiredCreditCardErrorMessage
	
	'Cant do a check out with an expired credit card!!!!'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'numberCard expiredDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 23:18:40'!
isExpired
	
	(expiredDate yearNumber < Date today yearNumber) ifTrue: [^True].
	(expiredDate yearNumber = Date today yearNumber) ifTrue: [^expiredDate monthIndex < Date today monthIndex].
	^False.
	
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 22:42:19'!
withNumber: aNumberCard andExpiredDate: anExpiredDate.
	
	numberCard := aNumberCard.
	
	expiredDate := anExpiredDate .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: 'numberCard theExpiredDate'!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GS 6/4/2024 23:11:59'!
withNumber: aNumberCard andExpiredDate: anExpiredDate 
	
	^CreditCard new withNumber: aNumberCard andExpiredDate: anExpiredDate.
	
	! !
