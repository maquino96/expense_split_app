# README
#Expense Split App
##by Matt Aquino and Zak Dagnall

This app is designed for Users to be able to log Expenses associated with a particular Event that they attended, with other people or alone, and then be able to split the total cost evenly among the participants of the Event. The app will then generate information on who owes who how much money, based on how much each person already contributed to the total cost (via paying for some Expenses) and how much each person's share should be. 

On each User's page, there is also visible a list of all outstanding Debts (if any) to any other Users, both what they owe and what they are owed. On this page, the Debts shown are consolidated from all their Debts across all Events of which they attended. For example, if Zak owes Matt $10 from dinner but Matt owes Zak $15 from bowling and $20 from that party, then on Matt's page it will show that Matt owes Zak $25 (15+20-10), and on Zak's page you will also see that Matt owes him $25. 

This app also lets you create a login Username (case sensitive) if one does not exist in the system for you. You must be logged-in (no password) in order to view any pages besides the login.

###This app makes use of Ruby on Rails, and has 5 models:
    * User
    * Event (which must have a non-nil date attribute)
    * Attendance (a joiner between User and Event)
    * Expense (which belongs to a particular attendance instance)
    * Debt (which belongs to an Event, and two Users (the creditor and the Debtor))

![Expense Split App ORM](/Expense_Split_App_ORM.png)

Debt instances are only created internally, from within the Event class. Events are incomplete (complete=false) by default, but when they are marked as complete by a User, the Event#finish method is called, which updates complete to true and also triggers the creation of all Debt instances associated with that Event. 

When a User joins an Event, a new Attendance instance is created. 

Users can log Expenses that they paid for (other Users must log their own Expenses).
Users also have the authority to delete one of their own Expenses, and to delete an Event that they authored. 
A User can remove themself from an Event that they attended. If they were the 'author' of the Event, 'authorship' (for purposes of deletion, mentioned above) passes to the second person to join the Event. When a User is removed from an Event, all of their Expenses in that Even are removed as well. 
A User can join an existing Event by searching for another User in the system, and can then see a list of all available (not yet marked as complete) Events that that User attended, for them to join.
A User can also un-mark an Event as complete, in order to reopen it and input more expenses. Upon marking it as complete again, the Debt intances will all be updated.


