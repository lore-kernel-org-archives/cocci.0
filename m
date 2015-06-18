From: skunk@iSKUNK.ORG (Daniel Richard G.)
Date: Wed, 17 Jun 2015 22:33:59 -0400
Subject: [Cocci] Various minor parsing bugs
Message-ID: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello list,

I am trialing the use of Coccinelle 1.0.0 on a large commercial
codebase. So far, I've encountered what appear to be a handful of
parsing bugs that have led to inconsistencies in the semantic-
patched output.

I have reduced the associated source code to a set of four minimal test
cases, contained in the attached tarball. For each bug, there is a C
source file, a Coccinelle patch, and possibly a "control" source file (a
minor edit to the test-case source that parses correctly, better
illustrating the issue).

My general use case is transforming a OEM codebase, with static and
global variables galore, into a thread-safe library. This, then,
necessitates adding a new "context" parameter to every function defined
in the codebase, and adding the new argument to every call to these same
functions. The semantic patches associated with these bug-cases will
generally attempt to add a new "void *ctx" parameter/argument to one or
more functions, and fail to do so due to the parsing issues.

Here are the [apparent] bugs I've found so far, then:

Bug 1: The patch adds a new "ctx" argument to calls to foo() and qux().
If qux() is in the argument list of a call to foo(), however, then the
foo() call is not modified.

Bug 2: Very strange case where parsing is affected by whitespace.

Bug 3: "break" at the end of a do{}while() loop throws off Coccinelle.
(It is pointless, but it should be handled.)

Bug 4: Coccinelle can't handle an expression whose content is affected
by a cpp conditional. (In my scenario, I would like it to ignore the
WIN32 side.) Can this be addressed with an appropriate macro-file
definition?


There were also a couple of issues that appeared to be parse errors, but
were actually due to Coccinelle not recognizing C99 integer types (e.g.
"int32_t"). Would these not be reasonable to add to the program's
default initializations?


--Daniel


-- 
Daniel Richard G. || skunk at iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cocci-bugs.tar.gz
Type: application/gzip
Size: 939 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150617/494ae51e/attachment.bin>
