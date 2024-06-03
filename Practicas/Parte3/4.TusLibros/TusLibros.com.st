!classDefinition: #CartTest category: #'TusLibros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:30:58'!
test01AssertThatANewCartIsEmpty

	|aCart |
	
	aCart := Cart new.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:33:41'!
test02DenyThatACartWithBooksIsEmpty

	|aCart |
	
	aCart := Cart new.
	aCart addToCatalog: #aBook1.
	aCart addToCart: #aBook1 withQuantity: 3. 
	
	self deny: aCart isEmpty.   ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:38:32'!
test03AssertThatPrintsCorrectlyItsListOfBooks

	|aCart|
	
	aCart := Cart new.
	aCart addToCatalog: #aBook1.
	aCart addToCart: #aBook1 withQuantity: 3. 
	
	self assert: aCart listCart equals: '|aBook1|3|'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:38:50'!
test03bisAssertThatPrintsCorrectlyItsListOfBooks

	|aCart|
	
	aCart := Cart new.
	aCart addToCatalog: #aBook1.
	aCart addToCatalog: #aBook2.
	aCart addToCart: #aBook1 withQuantity: 3. 
	
	aCart addToCart: #aBook2 withQuantity: 5. 
	
	self assert: aCart listCart equals: '|aBook2|5|aBook1|3|'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:39:03'!
test04AssertThatCanIncrementQuantityOfABook

	|aCart|
	
	aCart := Cart new.
	
	aCart addToCatalog: #aBook1.
	
	aCart addToCart: #aBook1 withQuantity: 3. 
	
	aCart addToCart: #aBook1 withQuantity: 2.
	
	self assert: aCart listCart equals: '|aBook1|5|'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:39:10'!
test05AssertThatCanDecrementQuantityOfABook

	|aCart|
	
	aCart := Cart new.
	
	aCart addToCatalog: #aBook1.
	
	aCart addToCart: #aBook1 withQuantity: 3. 
	
	aCart removeFromCart: #aBook1 withQuantity: 2.
	
	self assert: aCart listCart equals: '|aBook1|1|'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:39:26'!
test06AssertThatCantRemoveAnInvalidQuantityOfBooks

	|aCart|
	
	aCart := Cart new.
	
	aCart addToCatalog: #aBook1.
	
	aCart addToCart: #aBook1 withQuantity: 3. 
	
	
	
	[aCart removeFromCart: #aBook1 withQuantity: 5.
		self fail.]
	on: Error - MessageNotUnderstood
	do: [:anError | self assert: anError messageText equals: Cart invalidQuantityOfBooksToRemove.
		self assert: aCart listCart equals: '|aBook1|3|'.] ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:15:06'!
test07AssertThatCantRemoveABookThatIsNotInTheCart

	|aCart|
	
	aCart := Cart new.
	
	
	[aCart removeFromCart: #aBook1 withQuantity: 5.
		self fail.]
	on: Error - MessageNotUnderstood
	do: [:anError | self assert: anError messageText equals: Cart invalidQuantityOfBooksToRemove.
		self assert: aCart listCart equals: ''.] ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:44:13'!
test08AssertThatCantAddToCartABookThatIsNotInTheCatalog

	|aCart|
	
	aCart := Cart new.
	
	[aCart addToCart: #aBook1 withQuantity: 3. 
		self fail.]
	on: Error - MessageNotUnderstood
	do: [:anError | self assert: anError messageText equals: Cart cantAddToCartABookThatIsNotInTheCatalog.
		self assert: aCart listCart equals: ''.
		self deny: (aCart containsInTheCatalog: #aBook1)] ! !


!classDefinition: #Cart category: #'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:37:04'!
addToCart: aBook withQuantity: aBookQuantity 
	
	|actualQuantity|
	
	(catalog includes: aBook) ifFalse: [self error: self class cantAddToCartABookThatIsNotInTheCatalog].
	
	 actualQuantity := books at: aBook ifAbsent: [0].
	books at: aBook put: (actualQuantity + aBookQuantity) 
							
					
	
	   ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:34:28'!
addToCatalog: aBook 
	
	catalog add: aBook. ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:43:41'!
containsInTheCatalog: aBook 
	
	^catalog includes: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 15:59:28'!
isEmpty

	^books isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 18:35:36'!
isMinor: actualQuantity than: aBookQuantityToRemove

	^ (actualQuantity < aBookQuantityToRemove) ifTrue: [self error: self class invalidQuantityOfBooksToRemove]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 18:43:03'!
listCart
	|listToPrint|
	
	self isEmpty ifTrue: [^''].
	
	listToPrint := String new.
	
	listToPrint := listToPrint , '|'.
	
	books keysAndValuesDo: [:aBook :aQuantity| listToPrint := listToPrint , aBook asString , '|' , aQuantity asString , '|'].
	
	^listToPrint.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 18:35:36'!
removeFromCart: aBook withQuantity: aBookQuantityToRemove
	
	|actualQuantity|
	
	actualQuantity := books at: aBook ifAbsent: [0].
	
	self isMinor: actualQuantity than: aBookQuantityToRemove.
	
	books at: aBook put: (actualQuantity - aBookQuantityToRemove).! !


!Cart methodsFor: 'initialization' stamp: 'br 6/1/2024 21:30:06'!
initialize
	
	catalog := Set new.
	books := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 21:37:54'!
cantAddToCartABookThatIsNotInTheCatalog

	^'You cant add to a cart a book that is not in the catalog!!!!'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'br 6/1/2024 18:23:26'!
invalidQuantityOfBooksToRemove
	
	^'invalid quantity of books to remove!!!!'! !
