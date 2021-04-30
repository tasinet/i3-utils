# i3wm utilities

Various utilitiy scripts that make my i3wm experience easier.
Requires `jq` to be installed in order to parse JSON.

## i3-await.sh EVENT_TYPE

Awaits for a specific i3 event to come through, prints the event and exits.

Example: Useful for knowing when a new window was spawned. 

`./i3-await.sh new`

## i3-await-follow.sh EVENT_TYPE

Like i3-await but for multiple event (does not exit after first event)

Example:

`./i3-await-follow.sh new`

## open-in.sh WORKSPACE_INDEX COMMAND

Executes command and then moves the resulting window to workspace WORKSPACE_INDEX (if necessary)

Example:

`./open-in.sh 9 google-chrome`

## open-in-follow.sh WORKSPACE_INDEX COMMAND

Executes command,  moves the resulting window to workspace WORKSPACE_INDEX (if necessary) and then switches to the new workspace

Example:

`./open-in.sh 8 spotify`

## open-in-current.sh COMMAND

Tracks the current workspace before executing command. After executing command and a new window is spawned, it moves it to the current workspace if necessary (which may have changed in the meantime)

Example:

`./open-in-current.sh firefox`

## open-backwards.sh COMMAND

Opens a new window to the left/top instead of right/bottom

Example:

`./open-backwards.sh firefox`
