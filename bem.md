Another thing I've been incorporating into my CSS lately is the BEM naming convention. Basically it just means that I use
a double underscore to denote CSS that is associated with a larger block of HTML. So for example I have a standalone chunk
of styling called stonknote-show. Within that I've got stonknote show timestamp and show actions. Those are part of
the stonknote component of a page.

The double dash is used to represent variations of different things that could occur within a block. So I use the double
dash here to set the background colors on  my notes, which is a status that I set later on indicating which were my
good ideas and which ones were my bad ideas.


# Block

.my-block

# Element

Element is semantically tied to a given block.

.my-block__element
.stonknote-comment__text

# Modifier

Flags for blocks or elements

.my-block--flag
.my-block__element--flag

.stonknote-comment--redacted
.stonknote-comment__text--read