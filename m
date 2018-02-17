From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 15:34:43 +0100 (CET)
Subject: [Cocci] Clarification for scripted SmPL constraints
In-Reply-To: <9d550db4-cad4-f625-32da-173078fdde54@users.sourceforge.net>
References: <06b4669e-7419-e4f8-1761-4e58eef44fbd@users.sourceforge.net>
 <alpine.DEB.2.20.1802171437580.2205@hadrien>
 <388d5af8-d3e4-ee18-7481-3675e2b52024@users.sourceforge.net>
 <alpine.DEB.2.20.1802171510070.2205@hadrien>
 <9d550db4-cad4-f625-32da-173078fdde54@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171531330.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >> I would appreciate if the place for the desired predicate will be better explained.
> >>
> >> May they refer to a predefined function?
> >
> > When you write eg
> >
> > identifier x : script:python(...) { ... };
> >
> > or
> >
> > identifier x : script:ocaml(...) { ... };
> >
> > Between the { ... } you can put any code that you could put in a python or
> > ocaml script, respectively.
>
> Which parameters should be passed to the selected function?

You can always pass the declared metavariable.  You can put a
comma-separated list of inherited metavariables (r.a, r.b, ...) between
the parentheses, and then use a, b, etc in the script code.  If there are
no disjunctions in the rule and if the declared metavariable is no
seprated by ... from a metavariable previously declared in the same rule,
then the latter variable can be included in the () as well, with no rule
name, and then used in the script code.

julia
