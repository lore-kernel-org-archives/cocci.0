From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Apr 2014 23:28:19 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv=kpLyPX3ky2GMfPk9WtnmDTUxkKxpkg9Q68vb60WtUzUA@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
 <alpine.DEB.2.10.1404251823510.3323@hadrien>
 <535A8DEF.6070806@users.sourceforge.net>
 <alpine.DEB.2.10.1404252000560.2692@hadrien>
 <CABxcv=kpLyPX3ky2GMfPk9WtnmDTUxkKxpkg9Q68vb60WtUzUA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1404252326060.2176@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:

> Hello Julia,
> 
> On Fri, Apr 25, 2014 at 8:03 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Fri, 25 Apr 2014, SF Markus Elfring wrote:
> >
> >> > The attached patch illustrated a number of them.
> >>
> >> How do you see the chances for generalisation of this concrete example?
> >
> > I think it should be quite straightforward.  One either takes the
> > assignments out of the function and puts them into a structure
> > initializer, or if there is a structure initializer already, one cuts it
> > up into what is wanted for each of the separate functions.
> >
> > Maybe creating the name of the new structure is an issue?  I didn't look
> > carefully enough to see if there was a pattern.
> >
> > julia
> 
> I'm glad to know that should be straightforward. To name the new
> structure I've been trying to deduce the naming scheme that the
> original driver author used to name the GPIO operations and following
> that convention.
> 
> But if for the sake of simplicity we use a standard name that will be
> used on all drivers, that's ok too. After all the structures are
> static and later drivers maintainers can rename the structure if they
> want a more suitable name.

I thought you could look for the get or set field, see what it is assigned 
to, and make a new name from that one.  For maximum flexibility, you can 
make new names in ocaml or python code.  You can see how to do this in the 
file demos/pythontococci.cocci.

julia
