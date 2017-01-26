From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 16:57:58 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485445951.14760.16.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701261655450.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jan 2017, Johannes Berg wrote:

>
> > The problem is that Coccinelle lets you put fewer field initializers
> > than
> > are actually available.??The reasoning is that they are optional for
> > fields, and the user doesn't really know how many will be present in
> > each
> > case.??{} is the degenerate case where none are mentioned.??But that
> > should not apply to your case, 1) because you are removing the
> > braces, and
> > 2) because you aren't doing field initializations anyway.??I'll have
> > to look into it.
>
> Ok, thanks.
>
> I actually had a separate thought, that I could perhaps do something
> like
>
>
> {
> ... when != { ... }
> T x = {
> -  .field = E,
> };
> ... when != S
>     when any
> ++  x.field = E;
>
>
> To get rid of all the initializers, but (as I'm still on the phone) I
> haven't tried it yet :)
>
> Btw, how was the ++ supposed to work? I had to run this more than once
> to actually make it catch multiple instances of = {0}. Also, in the
> case above, even if it works, the order of initializations might be
> inverted if I run the spatch multiple times, so not sure I should do
> that.

Put a when any above the T x = line.

On the other hand, ++ makes no guarantee about the order in which things
are generated.

To ensure the order, put the when any above the T x line, and drop the one
below and run multiple times.  Then each run will work on the last one and
put it first, so they will come out in order.

julia

>
> johannes
>
