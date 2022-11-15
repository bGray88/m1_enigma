## Enigma

### Brandon Gray


Functionality:

I believe that my submission for this project implements both of the encrypt and decrypt functions completely. The command line interface funtionality is also included.

OOP:

I have created multiple classes for the encrypt and decrypt functions that inherit from a generic crypt class that contains most of the functionality for the program. The reason for the split was to maintain a DRY code format as these components perform many of the same functions. There have been two modules created to handle basic string and date funcitons in a respective -able named module format. These two modules only process specific data related to their asociated naming.

Ruby Conventions:

All of the lines and blocks should be indented and formatted correctly. There is one long line in the Crypt class that had to be split into two lines because of its length. That line would actually be my implementation of a hash- it uses key names in order to organize returned variables to the child classes through the super call. I've used many Ruby enumerables to perform functions necessary to the program expectations; map.with_index was used to give me the associated index when rotating the message characters, each_with_object was also used to insert every shift into an array without needing to declare one first.

TDD:

Testing is at SimpleCov rating of 100% and my perception is that I've tested situations related to nil and asssociated input. My git history will show that I have been making tests before coding.

Version Control:

There have been 72 commits and 20 pull requests in the attempt to maintain control over how many changes are made between each. I can't speak to logical chunks of functionality, but the intent was always to approach with a single function mindset.
