From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 09:39:36 +0100 (CET)
Subject: [Cocci] Software evolution after Coccinelle 1.0.0-rc24?
In-Reply-To: <54D1D876.2070305@users.sourceforge.net>
References: <alpine.DEB.2.02.1502032259220.2026@localhost6.localdomain6>
 <54D1D876.2070305@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1502040934340.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 4 Feb 2015, SF Markus Elfring wrote:

> > Now it is also possible to match a global variable,
> > by saying "global expression x;".
>
> Would you like to refer to "idexpression" here?

Yes, you are correct.  It should have been idexpression.

> > It is now possible to disable this behavior,
> > by putting disable prototypes in the rule header.
>
> Which software release will mention this functionality also in the manual?

I guess the next one.

> > Because of the conflict with the ... notation of Coccinelle,
> > the ... of C is written ...... (6 dots) in a semantc patch.
>
> How do you think about to support also two ellipsis characters
> (Unicode: 0x2026) there?

It seems too confusing.

> > --jobs <int>: Run the specified number of jobs in parallel.
>
> This addition is nice.
>
>
> > This option is not compatible with the use of an initialize or finalize
> > rule in the semantic patch.
>
> I find that this limitation will need more explanations.

There is no shared memory in ocaml.  Initialize is often used to create
variables that are intended to be used in multiple script occurrences and
finalize may accumulate their results.  The result could be unexpected if
the locations are not shared across all of the executions.  So the safe
thing is to simply disallow initialize and finalize.

> How do the calls to the script interpreters for OCaml and Python fit into
> the current architecture around process parallelism?

No idea what the question means.

> > This option furthermore creates a temporary directory in the directory
> > from which spatch is executed that has the name of the semantic patch
> > (without its extension) and that contains stdout and stderr files generated
> > by the various processes.
>
> Will it become possible to specify alternative paths for such
> temporary work directories?

We already have around 100 options.  Unless there is a big need for this,
I don't want to add another one.

> Further update suggestions:
> * When will the parameter "parse-handler" be described also in the documentation
>   source file "spatch_options.tex"?
>
> * Would you like to fix another dangling link for the topic "Tips and Tricks"?
>   http://coccinelle.lip6.fr/docs/main_grammar015.html

OK.

julia
