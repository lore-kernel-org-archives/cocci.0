From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 18:09:20 +0100 (CET)
Subject: [Cocci] Determination for the absence of an option in a
 function call
In-Reply-To: <a3c2fbd6-00f4-0113-aab8-4caeed631e1c@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
 <alpine.DEB.2.20.1802171703560.2205@hadrien>
 <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
 <alpine.DEB.2.20.1802171741560.2205@hadrien>
 <a3c2fbd6-00f4-0113-aab8-4caeed631e1c@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171808110.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >> I am working with the determination for memory allocation functions
> >> from Linux source files for a while.
> >> It matters in this software domain if the option ?__GFP_NOWARN? was applied
> >> (or not).
> >
> > <+...__GFP_NOWARN...+> in the appropriate argument position.
>
> It is easy to check the presence of such an identifier.
> But I find it very challenging to determine (by script code)
> if it is actually not passed (as an option) in a function call.

It's not clear what you want.  You will have to send some examples.

>
>
> >> Each function name is usually connected with a specific argument count.
> >> This fact has got some consequences for the development of corresponding
> >> SmPL scripts.
> >
> > I still have no idea what you are looking for here.
>
> I imagine that SmPL disjunctions (or further SmPL rules) will be
> relevant to distinguish the known parameter numbers.
>
> How would you manage the information which of the parameters
> would get the argument ?gfp? (for example)?

You have to match the definition of the function to find out what
parameter position you are interested in.  If the function is defined in
another file you may need to use iteration.  See demos/iteration.cocci.

julia
