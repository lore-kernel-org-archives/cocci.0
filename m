From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Apr 2014 12:59:44 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <alpine.DEB.2.10.1404251821570.3323@hadrien>
 <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1404261258030.2015@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:

> Hello Julia,
> 
> On Fri, Apr 25, 2014 at 6:23 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:
> >
> >> Hello,
> >>
> >> I'm a Linux kernel developer doing a big refactoring on the GPIO subsytem.
> >>
> >> I was wondering if the change I'm doing manually could be automated by
> >> using cocinelle but I've no experience neither writing semantic
> >> patches nor the SmPL language grammar.
> >
> > It looks quite possible.  In looking at the code, though, I wasn't sure
> > what is your strategy for where to place the new structure definition, in
> > the case where there was no structure before.  Would it be OK to put it
> > next to the probe function?
> >
> > julia
> 
> Thanks a lot for taking the time to look at this!
> 
> I've been adding the new structure definition right after all the
> functions have been defined since that is a common pattern found in
> other kernel subsystems.
> 
> But since this is a cleanup and if is going to be easier to define the
> semantic patch by placing the structure before the probe function then
> that works for me too and later drivers maintainers can send
> incremental patches to change wherever they find more suitable.

I would suggest to start with the case where there is already a global 
structure declaration.  Then you kow where to put the new structure and 
can probably find a reasonable algorithm for its name.

julia
