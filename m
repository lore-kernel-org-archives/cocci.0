From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Jan 2016 11:15:00 +0100 (CET)
Subject: [Cocci] script code on metavariables
In-Reply-To: <569CBA51.2040303@users.sourceforge.net>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1601181112390.2520@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > The basic notation is:
> >
> > position p : script:ocaml(params) { expression };
> >
> > Params can only be inherited metavariables.
>
> Would you like to clarify the specification of such parameters
> a bit more?

r.x

Unlike the case of an ordinary python/ocaml script, you are stuck with the
name x in the script code.

> > The expression should return true or false, ie true if the proposed value
> > of p is acceptable as a match, and false if it is not.
>
> Do you describe the introduction of generic predicate functions here?

I don't understand the question.  In any case, the script doesn't define
functions, due to the very limited syntax.  The normal case woudl be to
define some functions in the initialize rule of the semantic patch, and
just call them here.

thanks,
julia
