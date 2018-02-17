From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 17:42:52 +0100 (CET)
Subject: [Cocci] Determination for the absence of an option in a
 function call
In-Reply-To: <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
 <alpine.DEB.2.20.1802171703560.2205@hadrien>
 <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171741560.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >> But a safer source code analysis requires to distinguish these parameters in
> >> more detail.
> >>
> >> 1. How should be ensured that a specific option was not passed?
> >>
> >> 2. The parameter number becomes also relevant then.
> >>    How should functions be split based on their signature?
> >
> > I don't understand the questions.  What do you mean by option?
>
> Enumeration values (or preprocessor symbols) are often used for this kind
> of function parameters.
> Do you prefer the wording ?flag??
>
>
> > A command-line option of Coccinelle?
>
> Not in this clarification attempt.
>
>
> > A particular argument of action?
>
> Yes.
>
> I am working with the determination for memory allocation functions
> from Linux source files for a while.
> It matters in this software domain if the option ?__GFP_NOWARN? was applied
> (or not).

<+...__GFP_NOWARN...+> in the appropriate argument position.

>
>
> > For the second question, maybe you are looking for the following:
> >
> > @r@
> > expression list[n] es;
> > @@
> >
> > target = action(es)
> >
> > Now r.n is the number of arguments to action.
>
> This information can be useful for other analysis goals than what
> I have got in mind here.
> Each function name is usually connected with a specific argument count.
> This fact has got some consequences for the development of corresponding
> SmPL scripts.

I still have no idea what you are looking for here.

julia
