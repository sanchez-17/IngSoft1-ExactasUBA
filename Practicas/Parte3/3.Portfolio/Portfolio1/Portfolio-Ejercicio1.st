!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 20:27:52'!
test01xxxx
	|aPortfolio|
	aPortfolio := Portfolio new. 
	self assert: aPortfolio balance equals: 0.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 20:38:06'!
test02xxxx
	|aPortfolio anAccount |
	aPortfolio := Portfolio new. 
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio registerAnAccount: anAccount.
	self assert: aPortfolio balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 20:45:09'!
test03xxxx
	|aPortfolio anAccount1 anAccount2|
	aPortfolio := Portfolio new. 
	anAccount1 := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Deposit register: 200 on: anAccount2.
	aPortfolio registerAnAccount: anAccount1.
	aPortfolio registerAnAccount: anAccount2.
	self assert: aPortfolio balance equals: 300.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 20:49:43'!
test04xxxx
	|aPortfolio1 aPortfolio2|
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio1 registerAPortfolio: aPortfolio2.
	
	self assert: aPortfolio1 balance equals: 0.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/16/2024 21:06:41'!
test05xxxx
	|aPortfolio1 aPortfolio2 anAccount|
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio1 registerAPortfolio: aPortfolio2.
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio2 registerAnAccount: anAccount.
	
	self assert: aPortfolio1 balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/16/2024 21:22:13'!
test06xxxx
	|aPortfolio1 aPortfolio2 anAccount aPortfolio3 |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio3 := Portfolio new. 
	aPortfolio1 registerAPortfolio: aPortfolio2.
	aPortfolio1 registerAPortfolio: aPortfolio3.
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio2 registerAnAccount: anAccount.
	

	self assert: aPortfolio1 balance equals: 100.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/16/2024 21:19:53'!
test07xxxx
	|aPortfolio1 aPortfolio2 anAccount1 anAccount2|
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio1 registerAPortfolio: aPortfolio2.
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	aPortfolio2 registerAnAccount: anAccount1.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 50 on: anAccount2.
	aPortfolio1 registerAnAccount: anAccount2.

	self assert: aPortfolio1 balance equals: 150.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GS 5/16/2024 21:24:49'!
test08xxxx
	|aPortfolio1 aPortfolio2 anAccount aPortfolio3 aPortfolio4 |
	aPortfolio1 := Portfolio new. 
	aPortfolio2 := Portfolio new. 
	aPortfolio3 := Portfolio new. 
	aPortfolio4 := Portfolio new.
	aPortfolio1 registerAPortfolio: aPortfolio2.
	aPortfolio1 registerAPortfolio: aPortfolio3.
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio2 registerAnAccount: anAccount.
	aPortfolio1 registerAPortfolio: aPortfolio4.

	self assert: aPortfolio1 balance equals: 100.
	
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


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/16/2024 21:28:34'!
balance
	|sumPortfolios sumAccounts|
	sumPortfolios := portfolios sum:[:aPortfolio | aPortfolio balance] ifEmpty: [0].
	sumAccounts :=  accounts sum: [:anAccount | anAccount balance ] ifEmpty: [ 0].
	^sumAccounts + sumPortfolios ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 20:40:49'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'br 5/16/2024 20:54:31'!
registerAPortfolio: aPortfolio
	portfolios add: aPortfolio! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GS 5/16/2024 21:03:05'!
registerAnAccount: anAccount
	accounts add: anAccount ! !


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
