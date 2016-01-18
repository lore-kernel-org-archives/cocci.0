From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Jan 2016 11:43:03 +0100 (CET)
Subject: [Cocci] script code on metavariables
In-Reply-To: <569CBEB7.1030509@users.sourceforge.net>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
 <alpine.DEB.2.10.1601181112390.2520@hadrien>
 <569CBEB7.1030509@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1601181138430.2520@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Jan 2016, SF Markus Elfring wrote:

> >>> The expression should return true or false, ie true if the proposed value
> >>> of p is acceptable as a match, and false if it is not.
> >>
> >> Do you describe the introduction of generic predicate functions here?
> >
> > I don't understand the question.
>
> I try another wording ?
>
>
> > In any case, the script doesn't define functions, due to the very limited syntax.
>
> Do you exclude function definitions there so far?

It is not possible to write an OCaml function definition that has the form
of a C expression.  In practice, it is likely that one would only make a
function call, like I showed in my example.

> Does the described SmPL extension correspond to predicate functionality?

I guess.  The script code should return true or false.  If the script
returns true, the match succeeds.  If the script returns false, the match
fails.

> > The normal case woudl be to define some functions in the initialize rule
> > of the semantic patch, and just call them here.
>
> I like such source code organisation in principle for some use cases.
> Will this aspect need further considerations because of the evolving
> parallelisation support?
> https://github.com/coccinelle/coccinelle/issues/50

I believe that parallelism with -j only fails if there is a finalize.  An
initialize by itself should be OK.

julia
