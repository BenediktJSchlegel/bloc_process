
# This package is still work in progress

# Concept:

This project extends the well known 'BloC' - state management pattern commonly used in Flutter projects.

It defines a standardized way to define processes using BloC for state management. It also attempts to solve some of the issues
commonly encountered when developing large scale applications using BloC for state management.

The following section describes some of the core ideas for by this project.

Please note that this projects only attempts to standardize solutions for some common issues. How a specific issue needs to be tackled,
always depends on the project it is encountered in.

## Core Points:

### 1. Navigation

#### General thoughts:

A common way to handle navigation in BloC is to navigate from the UI, based on state emitted by the BloC. This is commonly done by
using `BlocListener` (or other similar) widgets.

For complex applications this quickly becomes messy. Also, this places logic related to navigation within the widget tree, not a natural place for this logic to be.

While this approach is acceptable in smaller scale or non process based applications, what part of a process (and which page) a user is on, can definitely be considered to be state
within a process.

#### Solution:

A separate `ProcessNavigator` component was introduced. It handles how navigation is performance when a process starts, ends or emits state.

This way it is possible to separate navigation from the UI and from the BloC itself, but still navigate based on the state.

### 2. Error Handling

#### General thoughts:

A common way to handle errors in BloC is to treat errors as state. Errors get caught and
appropriate error messages get set as state.

This has some issues. Firstly, it increases complexity of state, since many parts of state need to be extended to also include error state.
Secondly, a lot of the time, an error should only be handled once (like displaying the error to the user). When the error is part of state,
it is possible for event-handlers to be triggered multiple times (for instance, if an app is closed and reopened). Solving this causes even more complexity,
since events have to be used to reset the error state, after the error is displayed.

#### Solution:

Errors are not state. They are events that should be reported to the UI.

When an error happens that should be communicated to the UI once. How the
state gets changed when an error happens, differs on a case by case basis.

This is done by providing an error stream, in addition to the normal event stream of the BloC. This error stream can be consumed by the UI to display errors when they are
emitted from the Stream.

The `ProcessBlocConsumer` and `ProcessBlocListener` widgets can be used to easily listen to this error stream. They behave identically to their default BloC counterparts, but also
allow for listening to the error event stream.

### 3. Grouping of events

The `MultiChannelProcessBloc` allows definition of multiple `BlocChannel` objects. Each of which handles a subclass of events.

This gives more control of how code handling events, is seperated.

### 4. Chaining of processes

Sometimes processes are successive. The first process has an output that serves as the input to the second process.

The `ProcessChain` class allows for chaining of separate processes.



