From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Jan 2015 11:30:34 +0100 (CET)
Subject: [Cocci] adding function declarations
In-Reply-To: <54A67151.5080408@warlich.name>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011829330.2060@localhost6.localdomain6>
 <54A67151.5080408@warlich.name>
Message-ID: <alpine.DEB.2.10.1501021130150.2558@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2 Jan 2015, Christof Warlich wrote:

> Am 01.01.2015 um 18:33 schrieb Julia Lawall:
>
> > Unfortunately, your seemingly simple request raises some issues :)
>
> > First, you should apply the patch below to Coccinelle version 1.0.0-rc23
> (the latest version)
>
> It looks like you missed to include the patch you mentioned: I couldn't find
> anything appropriate to apply to the Coccinelle source code. Thus, I'm still
> playing with an unpatched version 1.0.0-rc23.
>
> > For some reason, the semantic patch parser is not allowing me to put
> > inline in the prototype. I will look into it and send another patch.
> >
> > Also for the following file:
> >
> > static inline __attribute__((always_inline)) int foo(int x) {
> >     return x;
> > }
> >
> > the output is missing a space before the attribute:
> > ...
>
> Yes, I could reproduce both using 1.0.0-rc23.

Interesting.  For me, without the patch, it crashed.

julia
