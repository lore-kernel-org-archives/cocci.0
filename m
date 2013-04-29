From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 29 Apr 2013 10:52:04 +0800 (SGT)
Subject: [Cocci] Coccinelle question
In-Reply-To: <CABjMXxrnhf54txKeu1G742YUqGGFP3j+xrCk340eBswQHrkRwA@mail.gmail.com>
References: <CABjMXxrnhf54txKeu1G742YUqGGFP3j+xrCk340eBswQHrkRwA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1304291042250.2000@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 24 Apr 2013, Majid Java wrote:

> Hello,
>
> last night i saw your website and projects from google search im really
> interested in what Coccinelle doing as i understand its kind of open source
> c parser library that follow in source code for variables and trace all
> source and headers for it,Right?

Specific points are that it follows the control-flow graph, via the ...
operator, it lets you match against metavariables that accumulate
properties from other matches, so you can make generic specifications, and
it is (mostly) aware of type information.

> now i have some questions:
> Are you take care of Variable Scopes when you are searching the source code?

Only somewhat.  Within a given rule, links to where C variables are bound
are taken into account.  But when a metavariable is inherited from one
rule to the next, all of this information is dropped.  This is in part
because Coccinelle supports transformation as well as matching, and you
could transform the variable declaration itself.  For example, you could
decide that you don't like variables being declared in the branches of an
if statement, and move the declarations up to top level.  The same
variables are still attached to the same binder, but by the way Coccinelle
is constructed (added code is not really interpreted) it would be hard to
detect this.

This may seem like a bug, but in practice, at least on Linux code, it can
be more of a feature.  Linux code often uses the same variable name for
the same conceptual quantity throughout a file, so it can be a way to find
all of the treatment of a particular value even when in the given file
there is no explicit interprocedural control-flow from one function using
the value to another.  Of course the result is not safe, but someone
looking at the result may have enough expertise to know that the right
thing is being done.

If you have further questions please feel free to write back.  If you join
the mailing list, you will get a faster response.

Thank you for your interest in Coccinelle.

julia
