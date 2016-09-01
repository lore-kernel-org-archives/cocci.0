From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Sep 2016 10:01:11 +0100 (IST)
Subject: [Cocci] Querying Git commits with Prequel
In-Reply-To: <41926033-b326-ea09-8d02-39ff7f898cad@users.sourceforge.net>
References: <alpine.DEB.2.10.1608291736460.2984@hadrien>
 <2ab7c81b-852a-b090-6ea6-54906d7bab30@users.sourceforge.net>
 <alpine.DEB.2.10.1609010857120.3086@hadrien>
 <41926033-b326-ea09-8d02-39ff7f898cad@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1609010956130.3568@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 1 Sep 2016, SF Markus Elfring wrote:

> >>    * How much will the data format flexibility evolve together with the handling
> >>      of a key word like "flexible" for metavariables?
> >
> > No idea what this means (data format flexibility).
>
> Is this key word the only one which was added to "PQL" (while it is processed by
> "SmPL" in other ways)?

There is an exhaustive list of changes in the paper.  To my recollection,
flexible is the only added keyword.  In SmPL, it would cause a parse error
in the place where it appears in PQL.

>
>
> >> 3. I get concerns from the section "5.2 Idealized syntax".
> >>    How would you categorise it according to the Chomsky-Sch?tzenberger hierarchy?
> >
> > No idea.  It seems like a straightforward BNF.
>
> Does the mentioned syntax belong to the category "context-free"?

I guess, to the extent that any programming language grammar is context
free.  Why does it matter?

>
> > The commit range is just X..Y.  X ad Y could be commit ids or tags (v4.0,
> > for example).
>
> Can this range be controlled or adjusted from within Prequel scripts anyhow?

No, it is specified on the command line.

>
> >> 5. Can the combination of words like "token" and "regular expression"
> >>    be occasionally confusing?
> >
> > Does the word regular expression occur in the paper?
>
> Yes, of course.   ;-)

It is used for git.  I'm missing what the issue is.

> Is the section "6.1 Commit selection" worth for a few more clarifications?
>
>
> >> 6. How interesting will discussions become around the used hardware
> >>    that is mentioned in the chapter "7 Evaluation" and the corresponding
> >>    software performance?
> >
> > Not sure what there is to discuss.
>
> Examples:
> * Number of processor cores

1.  As is specified in the paper.

>
> * Run time distribution for the involved scripts
>
> >> 7. How is the status for function and class libraries for this application domain?
> >
> > No idea what this means.
>
> Would you like to share any more information around the evolving code design structure?
> Which class libraries will eventually combine software modules?

I don't even know what a class library is in this context.

>
>
> How do you think about to use another public repository interface
> which would be similar to the one for Coccinelle?

I tried github, but the indices don't fit due to github file size
limitations.  Since I ignore all of the features of github other than the
basic git features, I don't care.  I believe that gforge has a bug
tracker, but I would have to figure out how to enable it.

julia
