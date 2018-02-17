From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 15:11:58 +0100 (CET)
Subject: [Cocci] Avoiding code duplication for SmPL constraints
In-Reply-To: <388d5af8-d3e4-ee18-7481-3675e2b52024@users.sourceforge.net>
References: <06b4669e-7419-e4f8-1761-4e58eef44fbd@users.sourceforge.net>
 <alpine.DEB.2.20.1802171437580.2205@hadrien>
 <388d5af8-d3e4-ee18-7481-3675e2b52024@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171510070.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >> Now I am looking again for further possibilities to avoid corresponding
> >> code duplication.
> >>
> >> * Scripted constraints might be a design option.
> >>   Unfortunately, I find the documentation for this functionality still incomplete.
> >
> > What information do you find to be lacking?
>
> I would appreciate if the place for the desired predicate will be better explained.
>
> May they refer to a predefined function?

When you write eg

identifier x : script:python(...) { ... };

or

identifier x : script:ocaml(...) { ... };

Between the { ... } you can put any code that you could put in a python or
ocaml script, respectively.

julia
