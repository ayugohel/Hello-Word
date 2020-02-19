# Hello-Word

CPU intensive task for Tableview Cell


It is a sample app in Swift that has a table view with 100 rows. Each row starts off with some
sample text (like “Hello World”). Each row does a CPU intensive task when it appears on screen.
The task is done once and only once per row. Once the task is done, the row’s text is updated to
“Hello World”(in bold).

Things to take into consideration:

1. CPU intensive task can be simulated using the sleep function with 2 second delay.
2. The scrolling should be smooth and the main thread shouldn’t stall.
3. Race conditions and thread safety needs to be handled correctly. — 
4. Bonus points for using right access controls (like private/final etc.).
