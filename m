From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Jun 2015 14:46:58 +0200 (CEST)
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
Message-ID: <alpine.DEB.2.10.1506231430140.2554@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 17 Jun 2015, Daniel Richard G. wrote:

> Hello list,
>
> I am trialing the use of Coccinelle 1.0.0 on a large commercial
> codebase. So far, I've encountered what appear to be a handful of
> parsing bugs that have led to inconsistencies in the semantic-
> patched output.
>
> I have reduced the associated source code to a set of four minimal test
> cases, contained in the attached tarball. For each bug, there is a C
> source file, a Coccinelle patch, and possibly a "control" source file (a
> minor edit to the test-case source that parses correctly, better
> illustrating the issue).
>
> My general use case is transforming a OEM codebase, with static and
> global variables galore, into a thread-safe library. This, then,
> necessitates adding a new "context" parameter to every function defined
> in the codebase, and adding the new argument to every call to these same
> functions. The semantic patches associated with these bug-cases will
> generally attempt to add a new "void *ctx" parameter/argument to one or
> more functions, and fail to do so due to the parsing issues.
>
> Here are the [apparent] bugs I've found so far, then:
>
> Bug 1: The patch adds a new "ctx" argument to calls to foo() and qux().
> If qux() is in the argument list of a call to foo(), however, then the
> foo() call is not modified.

Coccinelle picks one branch of the disjunction for matching against each
"statement" (loop header, etc).  It also tried to enforce the
prioritization of things early in a disjunction over things later.  This
means that in your example it can't match both something with arguments
and something without.

On the other hand, the following works fine:

@expression@
identifier F =~ "^(bar|qux)$";
@@
 F(
+ctx,
 ...)

> Bug 2: Very strange case where parsing is affected by whitespace.

No idea.  I'll look into it.

> Bug 3: "break" at the end of a do{}while() loop throws off Coccinelle.
> (It is pointless, but it should be handled.)

OK, I'll have to look into this one too.

> Bug 4: Coccinelle can't handle an expression whose content is affected
> by a cpp conditional. (In my scenario, I would like it to ignore the
> WIN32 side.) Can this be addressed with an appropriate macro-file
> definition?

The problem is that the #ifdef is being ignored.  It sees x += _timezone
timezone / 3600;  Unless you know the names of all the variables you want
to ignore, I don't see an easy solution.

> There were also a couple of issues that appeared to be parse errors, but
> were actually due to Coccinelle not recognizing C99 integer types (e.g.
> "int32_t"). Would these not be reasonable to add to the program's
> default initializations?

Just add #define int32_t int to standard.h.

Sorry not to have responded sooner.  Messages from nonmembers are
moderated, and since most such messages are spam, I don't pay a lot of
attention to them...

julia
