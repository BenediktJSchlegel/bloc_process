
#### Concept:
This package should define a clear way to define a process using BloC for state management.
To achieve this state management and navigation must be handled appropriately.


#### General Points:
- make state sections for each 'process part' (standardized way?)
- error handling/navigation split by 'process part'?
- modal-popups/toasts etc should be seperated from state as well (like errors)

---

## Navigation

### Default BloC way:
Handle state completely within the BloC. Handle navigation in the Widget 
with use of the BlocListener (and related) Widget.

#### Issues with approach:
Within a process, the page (or part of the process) the user is on, can be considered
to be part of the applications state. Looking at it that way, it is not appropriate
to handle changes to this special 'state' in a Widget.

Also handling navigation this way, it can be confusing where the logic for
navigation might be. There is no central point that decides how specific state
relates to navigation.


### Other tried way:
Pass pages and a seeded navigator to the bloc itself, allowing the Bloc to 
navigate directly.

#### Issues with approach:
Messy setup - Passing pages to the bloc is not very clean and gets messy fast.
While the current page can be described as state (which would get handled by the bloc)
actually causing change to the navigation stack is not a sensible responsibility
for the Bloc to have.

Makes unit testing harder.

### Possible Solution:
Move navigation to a separate component that handles navigation purely based
on the Bloc's state stream.

This way navigation can be seperated from the Widgets but also not overburden
the Bloc. The programmer may choose to navigate based on the generic state or
they might create a section of state that is purely meant for navigation control.



---
## Error Handling:

### Default BloC way:
Catch any exception that happens within a event-handler and emit state
according to the exception.

### General thoughts:
Errors are not state. They are events that should be reported to the UI.

When an error happens that should be communicated to the UI once. How the 
state gets changed when an error happens, differs on a case by case basis.

Example: 

    Take an example of a program that reads and displays a list of items from the network to the user. The user can pull to refresh to update the list of items. What if that refresh fails? We would like to pop up a dialog that the user can dismiss.
    The fact that the refresh fails doesn't mean we should throw away the list we previously loaded. The model here would throw that list away unless we duplicate all of the loaded state inside the error state.
    What if we get the error and the user dismisses it, navigates away from the app, then comes back? The state is still in this error state. Does he get a popup again?

### Possible Solution:
Generate a separate error stream that the bloc can add to when an error occurs.
This way error handling logic can be seperated completely from the apps normal
state.

This has the upside of leaving the bloc completely decoupled.

Start of error implementation for inspiration:
https://gist.github.com/felangel/6614b9ce0a536ef462138a0ba698053a