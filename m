From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 18:44:07 +0100 (CET)
Subject: [Cocci] Determination for the absence of an option in a
 function call
In-Reply-To: <b65bd20c-de90-2136-b375-246b873cf2a3@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
 <alpine.DEB.2.20.1802171703560.2205@hadrien>
 <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
 <alpine.DEB.2.20.1802171741560.2205@hadrien>
 <a3c2fbd6-00f4-0113-aab8-4caeed631e1c@users.sourceforge.net>
 <alpine.DEB.2.20.1802171808110.2205@hadrien>
 <b65bd20c-de90-2136-b375-246b873cf2a3@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171842050.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >> It is easy to check the presence of such an identifier.
> >> But I find it very challenging to determine (by script code)
> >> if it is actually not passed (as an option) in a function call.
> >
> > It's not clear what you want.
>
> Another try ?
>
>
> > You will have to send some examples.
>
> When we look at concrete Linux source code, we mostly see that
> the option ?__GFP_NOWARN? is just missing for a call of a function
> like ?devm_kmalloc?.
>
> An other analysis tool can show the information that such an identifier
> is referenced only in 207 files (from Linux 4.16-rc1).
>
> But how can the Coccinelle software help here to exclude these source
> code places from specific transformation attempts?

(
f(...,<+...__GFP_NOWARN...+>,...)
|
transformation
)

Alternatively,

@ok@
position p;
@@
f(...,<+...__GFP_NOWARN...+>,...)

@@
position p != ok.p;
@@
- f at p(...)
+ whatever

>
>
> >> How would you manage the information which of the parameters
> >> would get the argument ?gfp? (for example)?
> >
> > You have to match the definition of the function to find out what
> > parameter position you are interested in.
>
> It seems to be feasible to encode such knowledge for a small number
> of function names (in SmPL disjunctions or regular expressions).
>
> But how does the software situation look like when you would like
> to automate the search for interesting positions as much as possible?

My iteration suggestion covers this case.

julia
