!classDefinition: #CantRegister category: #'Portfolio-Ejercicio'!
Error subclass: #CantRegister
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:49'!
test02APortfolioWithAnAccount
	|aPortfolio anAccount |
	aPortfolio := Portfolio new. 
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio register: anAccount.
	self assert: aPortfolio balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:49'!
test03APortfolioWithTwoAccounts
	|aPortfolio anAccount1 anAccount2|
	aPortfolio := Portfolio new. 
	anAccount1 := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Deposit register: 200 on: anAccount2.
	aPortfolio register: anAccount1.
	aPortfolio register: anAccount2.
	self assert: aPortfolio balance equals: 300.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:49'!
test03bisAPortfolioWithThreeAccounts
	|aPortfolio anAccount1 anAccount2 anAccount3 |
	aPortfolio := Portfolio new. 
	anAccount1 := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	anAccount3 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Deposit register: 200 on: anAccount2.
	Deposit register: 500 on: anAccount3.
	aPortfolio register: anAccount1.
	aPortfolio register: anAccount2.
	aPortfolio register: anAccount3.
	self assert: aPortfolio balance equals: 800.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:34:47'!
test04APortfolioWithAnEmptyPortfolio
	"Este test se saca?"
	|aPortfolio1 aPortfolio2|
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio1 register: aPortfolio2.
	
	self assert: aPortfolio1 balance equals: 0.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:22'!
test05APortfolioWithAPortfolioThatHasAnAccount
	|aPortfolio1 aPortfolio2 anAccount|
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio1 register: aPortfolio2.
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio2 register: anAccount.
	
	self assert: aPortfolio1 balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:49'!
test06APortfolioWithTwoPortfoliosWhichOneOfThemHasAnAccount
	|aPortfolio1 aPortfolio2 anAccount aPortfolio3 |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio3 := Portfolio new. 
	aPortfolio1 register: aPortfolio2.
	aPortfolio1 register: aPortfolio3.
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio2 register: anAccount.
	

	self assert: aPortfolio1 balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:49'!
test07APortfolioWithAnAccountAndAPortfolioThatHasAnAccount
	|aPortfolio1 aPortfolio2 anAccount1 anAccount2|
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio1 register: aPortfolio2.
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	aPortfolio2 register: anAccount1.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 50 on: anAccount2.
	aPortfolio1 register: anAccount2.

	self assert: aPortfolio1 balance equals: 150.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 17:35:49'!
test08aPortfolioWithThreePortfoliosTwoOfWhichEachHaveAnAccount
	|aPortfolio1 aPortfolio2 anAccount aPortfolio3 aPortfolio4 |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio3 := Portfolio new. 
	aPortfolio4 := Portfolio new.
	aPortfolio1 register: aPortfolio2.
	aPortfolio1 register: aPortfolio3.
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio2 register: anAccount.
	aPortfolio1 register: aPortfolio4.

	self assert: aPortfolio1 balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:08:25'!
test09AssertThatATransactionHasRegistered
	|aPortfolio anAccount aTransaction|
	aPortfolio := Portfolio new. 
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aTransaction := Withdraw register: 100 on: anAccount.
	aPortfolio register: anAccount.
	
	self assert: (aPortfolio hasRegistered: aTransaction).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:08:49'!
test10DenyThatATransactionHasRegistered
	|aPortfolio anAccount aTransaction aTransaction2|
	aPortfolio := Portfolio new. 
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aTransaction := Withdraw register: 100 on: anAccount.
	aTransaction2 := Deposit for: 50.
	aPortfolio register: anAccount.
	
	self deny:(aPortfolio hasRegistered: aTransaction2).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:37:22'!
test11WithAnAccountAndAPortfolioThatHasATransaction
	|aPortfolio aPortfolio1 anAccount anAccount1 aTransaction|
	aPortfolio := Portfolio new. 
	aPortfolio1 := Portfolio new.
	aPortfolio register: aPortfolio1.
	
	anAccount := ReceptiveAccount new.
	Deposit register: 200 on: anAccount.
	aTransaction := Withdraw register: 100 on: anAccount.
	aPortfolio1 register: anAccount.
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 300 on: anAccount1.
	Withdraw register: 100 on: anAccount1.
	aPortfolio register: anAccount1.
	
	self assert:(aPortfolio hasRegistered: aTransaction).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:36:30'!
test12WithTwoAccountsAndWithAPortfolioThatHasTwoAccountsWithATransaction
	|aPortfolio aPortfolio1 anAccount anAccount1 anAccount2 anAccount3 aTransaction|
	aPortfolio := Portfolio new. 
	aPortfolio1 := Portfolio new.
	aPortfolio register: aPortfolio1.
	
	anAccount := ReceptiveAccount new.
	Deposit register: 300 on: anAccount.
	Withdraw register: 100 on: anAccount.
	aPortfolio register: anAccount.
	
	anAccount3 := ReceptiveAccount new.
	Deposit register: 500 on: anAccount3.
	aPortfolio register: anAccount3.
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 200 on: anAccount1.
	Withdraw register: 100 on: anAccount1.
	aPortfolio1 register: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	aTransaction := Deposit register: 300 on: anAccount2.
	aPortfolio1 register: anAccount2.
	
	self assert:(aPortfolio hasRegistered: aTransaction).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 19:31:53'!
test13xxxxxxAssertThatReturnsCorrectlyTransactionsOfOneAccount
	|aPortfolio anAccount transactions|
	transactions := Set new.
	aPortfolio := Portfolio new. 
	anAccount := ReceptiveAccount new.
	transactions add: (Deposit register: 100 on: anAccount).
	transactions add: ( Withdraw register: 100 on: anAccount).
	aPortfolio register: anAccount.
	
	self assert: transactions equals: aPortfolio transactions.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 19:27:21'!
test14xxx
	|aPortfolio anAccount1 anAccount2 transactions|
	transactions := Set new.
	aPortfolio := Portfolio new. 
	
	anAccount1 := ReceptiveAccount new.
	transactions add: (Deposit register: 100 on: anAccount1).
	transactions add: ( Withdraw register: 100 on: anAccount1).
	aPortfolio register: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	transactions add: (Deposit register: 500 on: anAccount2).
	transactions add: ( Withdraw register: 50 on: anAccount2).
	aPortfolio register: anAccount2.
	
	self assert: transactions equals: aPortfolio transactions.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 19:29:21'!
test15xxx
	|aPortfolio anAccount1 anAccount2 transactions anAccount3 |
	transactions := Set new.
	aPortfolio := Portfolio new. 
	
	anAccount1 := ReceptiveAccount new.
	transactions add: (Deposit register: 100 on: anAccount1).
	transactions add: ( Withdraw register: 100 on: anAccount1).
	aPortfolio register: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	transactions add: (Deposit register: 500 on: anAccount2).
	transactions add: ( Withdraw register: 50 on: anAccount2).
	aPortfolio register: anAccount2.
	
	anAccount3 := ReceptiveAccount new.
	transactions add: (Deposit register: 100 on: anAccount3).
	transactions add: ( Withdraw register: 1 on: anAccount3).
	aPortfolio register: anAccount3.
	self assert: transactions equals: aPortfolio transactions.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:26:26'!
test16yyyyyy
	"Esto lo borramos?"
	|aPortfolio1 aPortfolio2 anAccount |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 100 on: anAccount.
	
	aPortfolio1 register: anAccount.
	aPortfolio2 register: anAccount.
	
	self deny: (aPortfolio1 = aPortfolio2)
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:34:13'!
test17CantRegisterAnAccountToPortfolioThatIsAlreadyRegisteredInIt
	|aPortfolio anAccount |
	aPortfolio := Portfolio new. 
	
	anAccount := ReceptiveAccount new.
	
	aPortfolio register: anAccount.

	[ aPortfolio register: anAccount.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = Portfolio cantRegister .]
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:28:54'!
test18CanRegisterAnAccountThatIsAlreadyInOneSucesorPortfolio
	|aPortfolio1 anAccount aPortfolio2 |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	
	anAccount := ReceptiveAccount new.
	aPortfolio1 register: aPortfolio2.
	aPortfolio2 register: anAccount.
	
	[ aPortfolio1 register: anAccount.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = Portfolio cantRegister .]
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:27:53'!
test19CantRegisterAnAccountThatAlreadyIsInOneAncestorPortfolio
	|aPortfolio1 anAccount aPortfolio2 |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	
	anAccount := ReceptiveAccount new.
	aPortfolio1 register: aPortfolio2.
	aPortfolio1 register: anAccount.
	
	[ aPortfolio2 register: anAccount.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = Portfolio cantRegister .]
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:34:54'!
test20CantRegisterAPortfolioInTheSamePortfolio
	|aPortfolio |
	aPortfolio := Portfolio new. 
	
	[ aPortfolio register: aPortfolio.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = Portfolio cantRegister .]
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:47:50'!
test21xxxx
	|aPortfolio1 aPortfolio2 aPortfolio3 anAccount |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 	
	aPortfolio3 := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio1 register: aPortfolio3.
	aPortfolio2 register: aPortfolio3.
	aPortfolio2 register: anAccount.
	[ aPortfolio3 register: anAccount.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = Portfolio cantRegister .]
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:48:54'!
test22CantRegisterAPortfolioThatHasAnAccountWichIsAlreadyRegistered
	|aPortfolio1 aPortfolio2 anAccount |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 	
	anAccount := ReceptiveAccount new.
	
	aPortfolio1 register: anAccount.
	aPortfolio2 register: anAccount.
	[ aPortfolio1 register: aPortfolio2.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = Portfolio cantRegister .]
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 18:59:39'!
balanceCalculator: aBalance

	^aBalance + self value 


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 19:00:02'!
balanceCalculator: aBalance

	^aBalance - self value 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:01:40'!
WithdrawMoreThanBalanceError
	^'No se puede pedir mas de lo que se tiene'! !

!Withdraw class methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:04:02'!
register: aValue on: account
	| transaction |
	(account balance < aValue) ifTrue: [
			self error: Withdraw WithdrawMoreThanBalanceError.
		].

	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'assets parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:58:11'!
addParent: aParent
	parents add: aParent ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:21:05'!
addRootParentsTo: aRootParentsCollection
	parents ifEmpty:[aRootParentsCollection add: self]
		     ifNotEmpty:[ parents do:[:aParent| aParent addRootParentsTo: aRootParentsCollection ]]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:17:08'!
assertCanAdd: anAsset

	(self = anAsset or:[self isAlreadyTheAsset: anAsset]) ifTrue:[self error: self class cantRegister ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:13:39'!
balance
	^assets sum:[:anAsset | anAsset balance ] ifEmpty:[0].
	
	"|sumPortfolios sumAccounts|
	sumPortfolios := portfolios sum:[:aPortfolio | aPortfolio balance] ifEmpty: [0].
	sumAccounts :=  accounts sum: [:anAccount | anAccount balance ] ifEmpty: [ 0].
	^sumAccounts + sumPortfolios "! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:47:55'!
hasAlreadyTheAsset: anAssetToRegister 

	^assets anySatisfy: [:anAsset | 
					anAsset = anAssetToRegister 
					or:[anAsset hasAlreadyTheAsset: anAssetToRegister]
					or:[anAssetToRegister hasAlreadyTheAsset: anAsset]]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 18:47:08'!
hasRegistered: aTransaction
	|hasRegistered|
	hasRegistered := false. 
	assets do:[:anAsset | hasRegistered := hasRegistered or: [anAsset hasRegistered: aTransaction ]].
	^hasRegistered.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:52:05'!
initialize
	assets  := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:24:42'!
isAlreadyTheAsset: anAssetToRegister
	^self rootParents anySatisfy: [:aRootParent | aRootParent hasAlreadyTheAsset: anAssetToRegister].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:52:05'!
parent
	^parents! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:58:11'!
register: anAsset
	
	self assertCanAdd: anAsset.
	assets add: anAsset .
	(anAsset isKindOf: Portfolio) ifTrue:[anAsset addParent: self].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:18:15'!
rootParents
	|rootParents|
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	^rootParents.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/19/2024 19:29:38'!
transactions
	|transactions|
	transactions := Set new.
	 assets do:[:anAsset | 
		anAsset transactions do:[:aTransaction|
			transactions add:aTransaction]
		].
	^transactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 17:54:15'!
cantRegister
	^'You can not register an asset that is already registered'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'br 5/16/2024 19:03:38'!
balance
	|aBalance|
	aBalance := 0.
	transactions do: [:aTransaction | aBalance := aTransaction balanceCalculator: aBalance.
		].

	^aBalance
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'GS 5/22/2024 18:11:55'!
hasAlreadyTheAsset: anAssetToRegister 
	^false! !
