From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Jan 2016 13:05:35 +0100 (CET)
Subject: [Cocci] script code on metavariables
In-Reply-To: <569CD3DF.2010600@users.sourceforge.net>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
 <alpine.DEB.2.10.1601181112390.2520@hadrien>
 <569CBEB7.1030509@users.sourceforge.net>
 <alpine.DEB.2.10.1601181138430.2520@hadrien>
 <569CD3DF.2010600@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1601181301450.2520@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 18 Jan 2016, SF Markus Elfring wrote:

> > It is not possible to write an OCaml function definition that has the form
> > of a C expression.  In practice, it is likely that one would only make a
> > function call, like I showed in my example.
>
> Are method calls are also supported there depending on the reused
> programming language?

I don't know what is meant exactly by a method call, but anything that
looks like a valid C expression is fine.  The code will not be interpreted
by Coccinelle, only by the relevant scripting language, which is currently
only OCaml.  The restriction to being a C expression is only a parsing
issue.

> >> Will this aspect need further considerations because of the evolving
> >> parallelisation support?
> >> https://github.com/coccinelle/coccinelle/issues/50
> >
> > I believe that parallelism with -j only fails if there is a finalize.
>
> Would you like to clarify such an implementation detail a bit more?

if Cocci.has_finalize cocci_infos
            then
              begin
                pr2 "warning: parallel mode is disabled due to a finalize";
                (seq_fold, false)
              end

> Can the predicate function be eventually executed in parallel
> (by a dedicated thread or another background process)?

No, it runs in the same thread as the rest of the processing.

julia
