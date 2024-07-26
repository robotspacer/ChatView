# ChatView

I’ve been working on a SwiftUI chat view with a “mark read” button. The chat
view is a scrolling list of messages that shows the most recent messages at the
bottom. In this simplified example, the view automatically scrolls to the
bottom as new messages are added. In the actual app, there are options to
auto-scroll to the oldest unread message, or turn off auto-scroll.

The “mark read” button updates the view to indicate that the messages currently
visible on screen have been read. Read messages are shown at a reduced opacity.
This potentially modifies many rows, but since only a handful are on-screen at
one time, this shouldn’t be an issue.

[The initial commit](https://github.com/robotspacer/ChatView/commit/299c2b7b)
([Download ZIP](https://github.com/robotspacer/ChatView/archive/299c2b7b.zip))
demonstrates the problem. If you run the app (on macOS or iOS) and occasionally
click the “mark read” button, everything works fine initially. However as the
number of messages increases, performance starts to deteriorate. At around 500
messages, a brief delay becomes noticable when clicking “mark read.” At around
1000 messages, the app will start to beachball for several seconds when
clicking “mark read.” Eventually, several seconds turns to several minutes. The
number of messages in the view and the time between clicking the button both
affect how long the update takes.

Changing the `List` to a `LazyVStack` in a `ScrollView` (or a `Table`) solves
the problem, but with various unwanted side effects.

I tried many other things that did not solve the problem:

- Indicating the “read” state in a different way. For example I’ve tried just
  adding a line to indicate the “read” position, or adding an icon to the last
  “read” item. Changing the existing rows in any way causes problems, even if
  only 1 or 2 rows are affected.
- Setting a fixed size for rows. (This is not an acceptable solution anyway.)
- In macOS 15 Sequoia, `TrackVisibility` is no longer needed to keep track of
  visible rows. Removing this does not help though. In general, performance is
  better in macOS 15, but it still becomes a problem with enough rows.
- Using `.listStyle(.plain)` to simplify the view as much as possible.

## The Solution

[Commit 59251703](https://github.com/robotspacer/ChatView/commit/59251703)
([Download ZIP](https://github.com/robotspacer/ChatView/archive/59251703.zip))
shows the fix. It’s a very small change, just moving a few lines of code from
the `messageRow(_:)` view builder into the `ChatMessageView` struct.

The `messageRow(_:)` view builder was added to more closely resemble how my
own, more complex app is structured. You can simplify the code by removing this
function and moving its contents to the `ForEach` loop. The performance problem
will still be present. However you can now fix the issue by changing a single
line: move the `let readDate…` line outside of the `ForEach` loop.
